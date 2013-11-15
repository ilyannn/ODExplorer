//
//  ODPlainOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPlainOperation.h"
#import "ODOperationError+Parsing.h"

@implementation ODPlainOperation

- (NSError *)processResponse {
    NSString *stringResponse = [[NSString alloc] initWithData:self.response.data encoding:NSUTF8StringEncoding];
    
    if (!stringResponse)
        return [ODOperationError errorWithCode:kODOperationErrorBadEncoding
                                      userInfo:@{@"data":self.response.data}];

    _responsePlain = stringResponse;
    return nil;
}

- (NSError *)processPlainResponse {
    return  nil;
}

- (NSArray *)steps {
    __weak id self_ = self;
    return [[super steps] arrayByAddingObject: ^ { return [self_ processPlainResponse]; }];
}

@end
