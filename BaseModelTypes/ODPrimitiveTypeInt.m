//
//  ODPrimitiveTypeInt.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeInt.h"

@implementation ODPrimitiveTypeInt

+ (instancetype)withBits:(NSUInteger)bits {
    return [[self alloc] initWithBits:bits];
}

- (NSString *)primitiveName {
    return [NSString stringWithFormat:@"Int%lu", (unsigned long)_bits];
}

- (id)initWithBits:(NSUInteger)bits {
    _bits = bits;
    return [super init];
}

- (NSNumber *)valueForJSONNumber:(NSNumber *)obj {
    return obj;
}

- (NSNumber *)valueForJSONString:(NSString *)obj {
    return @([obj longLongValue]);
}

- (id)JSONObjectForValue:(NSNumber *)obj {
    if (_bits > 32) {
        return [NSString stringWithFormat:@"%@L", obj];
    } else {
        return obj;
    }
}

@end
