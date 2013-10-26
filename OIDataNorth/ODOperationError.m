//
//  ODOperationError.m
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperationError.h"

NSString * const ODOperationErrorDomain = @"com.ilya";

@implementation ODOperationError
+ (instancetype)errorWithCode:(ODOperationErrorType)code userInfo:(NSDictionary *)userInfo {
    return [self errorWithDomain:ODOperationErrorDomain
                            code:code
                        userInfo:userInfo
            ];
}

- (NSString *)localizedDescription {
    static NSArray *descriptions;
    if (!descriptions) {
        descriptions = @[ODOPERATIONERRORTYPEDESCRIPTIONS];
    }
    
    if (self.code >= 0 && self.code < descriptions.count)
        return descriptions[self.code];

    return [super localizedDescription];
}

@end
