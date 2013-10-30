//
//  ODOperationResponse.m
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperationResponse.h"
#import "ODOperationError.h"

@implementation ODOperationResponse

- (NSInteger) majorProtocolVersion {
    NSString *protocolVersion = self.HTTPResponse.allHeaderFields[@"DataServiceVersion"];
    return [protocolVersion integerValue];
}

- (NSInteger) majorStatus {
    if (!self.HTTPResponse) return 0;
    return [self.HTTPResponse statusCode] / 100;
}

- (NSError *)statusCodeError {
    ODOperationErrorType code;
    switch (self.majorStatus) {
            
        case 4:  code = kODOperationErrorClientSide;
            break;

        case 5:  code = kODOperationErrorServerSide;
            break;
            
        default:
            return nil;
    }
    return [ODOperationError errorWithCode:code userInfo:@{@"response":self}];
}

@end
