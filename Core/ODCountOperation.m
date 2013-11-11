//
//  ODCountOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCountOperation.h"
#import "ODOperationResponse.h"
#import "ODOperationError+Parsing.h"

NSString *const ODQueryCountString  = @"$count";

@implementation ODCountOperation

- (NSURL *)URL {
    return [[super URL] URLByAppendingPathComponent:ODQueryCountString];
}

- (NSError *)processPlainResponse {
    NSInteger responseCount = [self.responsePlain integerValue];
    if (responseCount < 0 ) return [ODOperationError errorWithCode:kODOperationErrorNonsenseData
                                                          userInfo:@{@"data":@(responseCount)}];
    _responseCount = responseCount;
    return nil;
}

+ (NSError *)errorForKind:(ODResourceKind)kind {
    ODAssertOperation(kind != ODResourceKindEntity, @"You can't count an entity.");
    return nil;
}

@end
