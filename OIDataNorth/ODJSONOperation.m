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

- (NSArray *)acceptStrings {
    
    NSArray *odataTypes = @[@"fullmetadata", @"verbose", @""];
    NSMutableArray *strings = [NSMutableArray new];
    NSString *core = @"application/json";
    
    [odataTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *components = @[core,
                                [obj length]? [NSString stringWithFormat:@";odata=%@", obj] : @"",
                                [NSString stringWithFormat:@";q=0.%d", 9 - idx]];
        [strings addObject:[components componentsJoinedByString:@""]];
    }];

    return [strings copy];
}

- (void)changeHTTPHeaders:(NSMutableDictionary *)headers {
    [super changeHTTPHeaders:headers];
    headers[@"Accept"] = [[self acceptStrings] componentsJoinedByString:@","];
 //   headers[@"Accept"] = @"application/json;odata=,application/json;odata=;q=0.7,;q=0.5";
}

- (NSError *)processResponse {
    NSError *error;
    _responseJSON = [NSJSONSerialization JSONObjectWithData:self.response.data options:0 error:&error];
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
