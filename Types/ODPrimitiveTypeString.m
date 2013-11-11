//
//  ODPrimitiveTypeString.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeString.h"

@implementation ODPrimitiveTypeString

- (NSString *)primitiveName {
    return @"String";
}

- (id)valueForJSONString:(NSString *)obj {
    return obj;
}

- (id)valueForJSONNumber:(NSNumber *)obj {
    return [NSString stringWithFormat:@"%@", obj];
}

- (NSString *)JSONObjectForValue:(NSString *)value {
    return value;
}

@end
