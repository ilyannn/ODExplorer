//
//  ODOperationError.h
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const ODOperationErrorDomain;

typedef NS_ENUM(NSInteger, ODOperationErrorType) {
    kODOperationErrorBadRequest = 0,
    kODOperationErrorClientSide,
    kODOperationErrorServerSide,
    kODOperationErrorAbstractOperation,
    kODOperationErrorBadEncoding,
    kODOperationErrorJSONNotOData,
    kODOperationErrorNonsenseData,
};

#define ODOPERATIONERRORTYPEDESCRIPTIONS \
   @"The request couldn't be created by the operation class." ,\
   @"Server reported that the request is malformed." ,\
   @"Server reported internal problems that prevented request's completion." ,\
   @"Methods for processing the response are not implemented in this operation." ,\
   @"The format in which server returned the response doesn't decode." ,\
   @"The response was successfully read as a JSON object, but it doesn't seem to conform to OData protocol." ,\
   @"The response data was successfully decoded, but there's no way to make sense of it"

@interface ODOperationError : NSError
+ (instancetype)errorWithCode:(ODOperationErrorType)code userInfo:(NSDictionary *)userInfo;
@end
