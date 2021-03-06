//
//  ODOperationError.h
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

extern NSString * const ODOperationErrorDomain;

typedef NS_ENUM(NSInteger, ODOperationErrorType) {
    kODOperationErrorInvalid = 1,
    kODOperationErrorBadRequest,
    kODOperationErrorClientSide,
    kODOperationErrorServerSide,
    kODOperationErrorAbstractOperation,
    kODOperationErrorBadEncoding,
    kODOperationErrorJSONNotOData,
    kODOperationErrorNonsenseData,
    kODOperationErrorModelMismatch,
};

@interface ODOperationError : NSError
+ (instancetype)errorWithCode:(ODOperationErrorType)code userInfo:(NSDictionary *)userInfo;
+ (instancetype)errorInvalidWithReason:(NSString *)reason;
+ (instancetype)errorModelWithReason:(NSString *)reason;
@end
