//
//  ODJSONOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODJSONOperation.h"
#import "ODOperationResponse.h"
#import "ODOperationError.h"

@implementation ODJSONOperation

static AFJSONResponseSerializer *_sharedResponseSerializer;
- (AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer {
    if (!_sharedResponseSerializer) {
        _sharedResponseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sharedResponseSerializer;
}

- (NSDictionary *)addedHTTPHeaders {
    return @{ @"Accept" : @"application/json" };
}

- (NSError *)processResponse:(ODOperationResponse *)response {
    NSError *error;
    id responseObject = [self.responseSerializer responseObjectForResponse:response.HTTPResponse
                                                                      data:response.data
                                                                     error:&error];
    if (error) return error;
    return [self processJSONResponse:responseObject];
}

- (NSError *)processJSONResponse:(id)responseJSON ODErrorAbstractOp

@end
