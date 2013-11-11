//
//  ODPrimitiveTypeByte.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeByte.h"

@implementation ODPrimitiveTypeByte

- (NSString *)primitiveName {
    return @"Byte";
}

- (NSNumber *)valueForJSONString:(NSString *)obj {
    unsigned int result;
    return [[NSScanner scannerWithString:obj] scanHexInt:&result] ? @(result) : nil;
}

@end
