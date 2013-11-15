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

- (NSInteger)majorProtocolVersion {
    NSString *protocolVersion = self.HTTPResponse.allHeaderFields[@"DataServiceVersion"];
    return [protocolVersion integerValue];
}

- (NSInteger)maxMajorProtocolVersion {
    NSString *protocolVersion = self.HTTPResponse.allHeaderFields[@"MaxDataServiceVersion"];
    return [protocolVersion integerValue];
}

- (NSInteger)majorStatus {
    return [self.HTTPResponse statusCode] / 100;
}

- (NSString *)contentType {
    return self.HTTPResponse.allHeaderFields[@"Content-Type"];
}

- (BOOL)isJSON {
    return [self.contentType rangeOfString:@"application/json"].location == 0;
}

- (BOOL)isVerbose {
    return [self.contentType rangeOfString:@";odata=verbose"].location != NSNotFound;
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
    
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    [userInfo setValue:self.HTTPResponse.allHeaderFields forKey:@"headers"];
    [userInfo setValue:[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding] forKey:@"body"];

    return [ODOperationError errorWithCode:code userInfo: userInfo];
}

@end
