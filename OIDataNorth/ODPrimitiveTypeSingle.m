//
//  ODPrimitiveTypeSingle.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeSingle.h"

@implementation ODPrimitiveTypeSingle

- (NSString *)primitiveName {
    return @"Single";
}

- (NSNumber *)valueForJSONNumber:(NSNumber *)obj {
    return obj;
}

- (NSNumber *)valueForJSONString:(NSString *)obj {
    float value = [obj floatValue];
    return @(value);
}

@end
