//
//  ODJSONOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODJSONOperation.h"
#import "ODOperationResponse.h"
#import "ODOperationError+Parsing.h"

@implementation ODJSONOperation

static AFJSONResponseSerializer *_sharedResponseSerializer;
- (AFHTTPResponseSerializer <AFURLResponseSerialization> *)JSONResponseSerializer {
    if (!_sharedResponseSerializer) {
        _sharedResponseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sharedResponseSerializer;
}

-(void)changeHTTPHeaders:(NSMutableDictionary *)headers {
    [super changeHTTPHeaders:headers];
    headers[@"Accept"] = @"application/json";
}

// This method has access to protocol version, HTTP headers and other OData encoding metadata.
- (NSError *)processResponse {
    NSError *error;
    self.JSONResponse = [[self JSONResponseSerializer] responseObjectForResponse:self.response.HTTPResponse
                                                                      data:self.response.data
                                                                     error:&error];
    return error;
}

- (NSError *)processJSONResponse {
    switch (self.response.majorProtocolVersion) {
        case 3: return [self processJSONResponseV3];
            
        default:
            return [ODOperationError errorWithCode:kODOperationErrorJSONNotOData
                                          userInfo:@{NSLocalizedFailureReasonErrorKey
                                                     : @"Server responded with unsupported OData version." }];
    }
}

- (NSError *)processJSONResponseV3 ODErrorAbstractOp

- (NSArray *)steps {
    __weak id self_ = self;
    return [[super steps] arrayByAddingObject:(NSError *) ^{ return [self_ processJSONResponse];} ];
}

@end
