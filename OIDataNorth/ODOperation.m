//
//  OIDataQuery.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperation.h"
#import "ODOperationError.h"

NSString * const ODHTTPVerbGet = @"GET";

@implementation ODOperation

// Redefine this in subclasses.
- (NSString *)method {
    return ODHTTPVerbGet;
}

- (id)init {
    self = [super init];
    if (self) {
        _parameters = [NSMutableDictionary new];
    }
    return self;
}

+ (instancetype)operationWithResource:(ODResource *)resource {
    ODOperation *operation = [self new];
    operation.resource = resource;
    return operation;
}

- (AFHTTPRequestSerializer *)requestSerializer {
    static AFJSONRequestSerializer *_sharedRequestSerializer;
    if (!_sharedRequestSerializer) {
        _sharedRequestSerializer = [AFJSONRequestSerializer serializer];
    }
    return _sharedRequestSerializer;
}

- (AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer {
    return nil;
}

- (NSURL *)URL {
    return self.resource.URL;
}

- (NSDictionary *)addedHTTPHeaders {
    return nil;
}

- (NSURLRequest *)request {
    NSMutableURLRequest *mutableRequest = [self.requestSerializer
                                           requestWithMethod:[self method]
                                           URLString:self.URL.absoluteString
                                           // this helps to get rid of unnecesary ? in the URL
                                           parameters:self.parameters.count ? self.parameters:nil
                                           ];
    [[self addedHTTPHeaders] enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        [mutableRequest addValue:obj forHTTPHeaderField:key];
    }];
    return [mutableRequest copy];
}

- (id)valueForKey:(NSString *)key {
    return [self.parameters valueForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [self.parameters setValue:value forKey:key];
}

- (NSError *)synchronousPerformWithError {
    NSURLRequest *request = [self request];
    
    if (!request) {
        return [ODOperationError errorWithCode:kODOperationErrorBadRequest userInfo:nil];
    }

    ODOperationResponse *response;
    NSError *error;

    if ((error = [self performRequest:request intoResponse:&response])) return error;
    if ((error = [response statusCodeError])) return error;
    if ((error = [self processResponse:response])) return error;
    if (self.onSuccess) self.onSuccess(self);
    
    return nil;
}

// Marshalling the result of sending an asynchronous request into
- (NSError *)performRequest:(NSURLRequest *)request intoResponse:(ODOperationResponse **)response {

    NSError *URLError;
    NSURLResponse *URLResponse;

    NSLog(@"%@: %@", NSStringFromClass(self.class), request);

    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&URLResponse
                                                     error:&URLError];
    if (URLError) {
        return /*[ODOperationError errorWithCode:kODOperationErrorCommunication
                userInfo:@{ NSUnderlyingErrorKey : URLError }];*/ URLError;
    }
    
    *response = [ODOperationResponse new];
    (*response).request = request;
    (*response).data = data;
    
    if ([URLResponse isKindOfClass:[NSHTTPURLResponse class]])
        (*response).HTTPResponse = (NSHTTPURLResponse *)URLResponse;

    return nil;
}

- (void)main {
    self.error = [self synchronousPerformWithError];
}

- (NSError *)processResponse:(ODOperationResponse *)response {
    return [ODOperationError errorWithCode:kODOperationErrorAbstractOperation userInfo:nil];
}



@end
