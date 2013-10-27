//
//  ODOperationError.m
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperationError.h"

NSString * const ODOperationErrorDomain = @"com.ilya";
NSString * const ODOperationErrorTable = @"ODOperationError";

@implementation ODOperationError
+ (instancetype)errorWithCode:(ODOperationErrorType)code userInfo:(NSDictionary *)userInfo {
    return [self errorWithDomain:ODOperationErrorDomain
                            code:code
                        userInfo:userInfo
            ];
}

+ (instancetype)errorInvalidWithReason:(NSString *)reason {
    NSString *value = NSLocalizedStringFromTable(reason, ODOperationErrorTable, nil);
    return [self errorWithCode:kODOperationErrorInvalid
                      userInfo:@{NSLocalizedFailureReasonErrorKey: value} ];
}

- (NSString *)localizedDescription {
    NSString *key = [NSString stringWithFormat:@"%i", self.code];
    NSString *value = NSLocalizedStringFromTable(key, ODOperationErrorTable, nil);
    return value ? value : [super localizedDescription];
}

@end
