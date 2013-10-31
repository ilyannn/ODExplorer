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
    headers[@"Accept"] = @"application/json;odata=verbose";
}

// This method has access to protocol version, HTTP headers and other OData encoding metadata.
- (NSError *)processResponse {
    NSError *error;
    _responseJSON = [[self JSONResponseSerializer] responseObjectForResponse:self.response.HTTPResponse
                                                                      data:self.response.data
                                                                     error:&error];
    return error;
}

- (BOOL)canBeEmpty {
    return YES;
}

- (NSError *)processJSONResponse {
    ODAssertOData(self.canBeEmpty || self.responseJSON,
                    @{NSLocalizedFailureReasonErrorKey : @"The response JSON should be non-empty."});
    switch (self.response.majorProtocolVersion) {
        case 3:
            if (![self.response isVerbose]) {
                return [self processJSONResponseLight];
            }
            
        case 1:
        case 2: return [self processJSONResponseVerbose];
            
        default:
            return [ODOperationError errorWithCode:kODOperationErrorJSONNotOData
                                          userInfo:@{NSLocalizedFailureReasonErrorKey
                                                     : @"Server responded with unsupported OData version." }];
    }
}

- (NSError *)processJSONResponseVerbose ODErrorAbstractOp
- (NSError *)processJSONResponseLight ODErrorAbstractOp

- (NSArray *)steps {
    __weak id self_ = self;
    return [[super steps] arrayByAddingObject:(NSError *) ^{ return [self_ processJSONResponse];} ];
}

@end
