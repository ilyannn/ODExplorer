//
//  OIDataQuery.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperation.h"

NSString *const ODHTTPVerbGet = @"GET";

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

- (void)main {
    NSHTTPURLResponse *response;
    NSError *error;
    NSURLRequest *request = [self request];
    
    NSLog(@"%@: %@", NSStringFromClass(self.class), request);
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSInteger status = error ? -1 : response.statusCode / 100;
    
    switch (status) {
        case 2 :
            [self processResponse:response data:data];
            if (self.onSuccess)
                self.onSuccess(self);
            break;
            
        default:
            [self processFailure:response data:data];
            break;
    }
}

- (void)processResponse:(NSHTTPURLResponse *)response data:(NSData *)data {
}

- (void)processFailure:(NSHTTPURLResponse *)response data:(NSData *)data {
}

@end
