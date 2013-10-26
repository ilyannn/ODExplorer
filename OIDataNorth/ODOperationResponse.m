//
//  ODOperationResponse.m
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperationResponse.h"

@implementation ODOperationResponse


- (NSInteger) majorProtocolVersion {
    NSString *protocolVersion = self.HTTPResponse.allHeaderFields[@"DataServiceVersion"];
    return [protocolVersion integerValue];
}

@end
