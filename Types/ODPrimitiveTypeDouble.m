//
//  ODPrimitiveTypeDouble.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeDouble.h"

@implementation ODPrimitiveTypeDouble

- (NSString *)primitiveName {
    return @"Double";
}

- (NSNumber *)valueForJSONNumber:(NSNumber *)obj {
    return obj;
}

- (NSNumber *)valueForJSONString:(NSString *)obj {
    double value = [obj doubleValue];
    return @(value);
}

@end
