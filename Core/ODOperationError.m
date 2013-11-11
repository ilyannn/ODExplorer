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
    // SET BREAKPOINT HERE
    return [self errorWithDomain:ODOperationErrorDomain
                            code:code
                        userInfo:userInfo
            ];
}

+ (instancetype)errorInvalidWithReason:(NSString *)reason {
    NSString *value = NSLocalizedStringFromTable(reason, ODOperationErrorTable, nil);
    return [self errorWithCode:kODOperationErrorInvalid
                      userInfo:!value ? nil : @{NSLocalizedFailureReasonErrorKey: value} ];
}

+ (instancetype)errorModelWithReason:(NSString *)reason {
    NSString *value = NSLocalizedStringFromTable(reason, ODOperationErrorTable, nil);
    return [self errorWithCode:kODOperationErrorModelMismatch
                      userInfo:!value ? nil : @{NSLocalizedFailureReasonErrorKey: value,
                                                @"stack" : [NSString stringWithFormat:@"%@", [NSThread callStackSymbols]]} ];
}

- (NSString *)localizedDescription {
    NSString *key = [NSString stringWithFormat:@"%li", (long)self.code];
    NSString *value = NSLocalizedStringFromTable(key, ODOperationErrorTable, nil);
    return value ? value : [super localizedDescription];
}

@end
