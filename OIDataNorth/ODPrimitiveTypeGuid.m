//
//  ODPrimitiveTypeGuid.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeGuid.h"

@implementation ODPrimitiveTypeGuid

- (NSString *)primitiveName {
    return @"Guid";
}

- (NSUUID *)valueForJSONString:(NSString *)obj {
    return [[NSUUID alloc] initWithUUIDString:obj];
}

@end
