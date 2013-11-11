//
//  ODPrimitiveTypeBoolean.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeBoolean.h"

@implementation ODPrimitiveTypeBoolean

- (NSString *)primitiveName {
    return @"Boolean";
}

- (id)valueForJSONNumber:(NSNumber *)obj {
    return obj;
}

- (NSNumber *)JSONObjectForValue:(NSNumber *)value {
    return [value boolValue] ? [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
}

@end
