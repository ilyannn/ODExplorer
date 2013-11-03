//
//  ODHTTPOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/30/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODHTTPOperation.h"

#import "ODOperationError+Parsing.h"
#import "AFNetworking/AFNetworking.h"

NSString *const ODHTTPVerbGet = @"GET";

@implementation ODHTTPOperation

+ (NSString *)minODataVersionString {
    return [NSString stringWithFormat:@"%d.0", MIN_ODATA_MAJOR_VERSION];
}

+ (NSString *)maxODataVersionString {
    return [NSString stringWithFormat:@"%d.0", MAX_ODATA_MAJOR_VERSION];
}

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
    return [self.retrievalInfo URL];
}

- (void)changeHTTPHeaders:(NSMutableDictionary *)headers {
    headers[@"MinDataServiceVersion"] = [self.class minODataVersionString];
    headers[@"MaxDataServiceVersion"] = [self.class maxODataVersionString];
}

- (NSError *)prepareRequest {
    NSMutableURLRequest *mutableRequest = [self.requestSerializer
                                           requestWithMethod:[self method]
                                           URLString:self.URL.absoluteString
                                           // this helps to get rid of unnecesary ? in the URL
                                           parameters:self.parameters.count ? self.parameters:nil
                                           ];
    if (!mutableRequest) {
        return [ODOperationError errorWithCode:kODOperationErrorBadRequest userInfo:nil];
    }
    
    NSMutableDictionary *allHeaders = [[mutableRequest allHTTPHeaderFields] mutableCopy];
    
    [self changeHTTPHeaders:allHeaders];
    mutableRequest.allHTTPHeaderFields = allHeaders;
    
    self.request = [mutableRequest copy];
    return nil;
}

- (id)valueForKey:(NSString *)key {
    return [self.parameters valueForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [self.parameters setValue:value forKey:key];
}

// Marshalling the result of sending an asynchronous request into
- (NSError *)responseFromRequest {
    NSError *URLError;
    NSURLResponse *URLResponse;
    
    //    NSLog(@"%@: %@", NSStringFromClass(self.class), request);
    
    NSData *data = [NSURLConnection sendSynchronousRequest:self.request
                                         returningResponse:&URLResponse
                                                     error:&URLError];
    if (URLError) {
        return URLError;
        /*[ODOperationError errorWithCode:kODOperationErrorCommunication
         userInfo:@{ NSUnderlyingErrorKey : URLError }]; // wrap communication errors? */
    }
    
    self.response = [ODOperationResponse new];
    self.response.data = data;
    
    if ([URLResponse isKindOfClass:[NSHTTPURLResponse class]])
        self.response.HTTPResponse = (NSHTTPURLResponse *)URLResponse;
    
    return nil;
}

- (NSError *)processResponse {
    return [ODOperationError errorWithCode:kODOperationErrorAbstractOperation userInfo:nil];
}

- (NSArray *)steps {
    __weak ODHTTPOperation *self_ = self;
    return [[super steps] arrayByAddingObjectsFromArray: @[
               ^{ return [self_ prepareRequest]; },
               ^{ return [self_ responseFromRequest]; },
               ^{ return [self_.response statusCodeError]; },
               ^{ return [self_ processResponse]; },
               ]];
}

@end
