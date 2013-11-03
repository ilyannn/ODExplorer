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
    return [NSString stringWithFormat:@"Int%lu", (long)_bits];
}

- (id)initWithBits:(NSUInteger)bits {
    if (self = [super init]) {
        _bits = bits;
    }
    return self;
}

- (NSNumber *)valueForJSONNumber:(NSNumber *)obj {
    return obj;
}

- (NSNumber *)valueForJSONString:(NSString *)obj {
    return @([obj longLongValue]);
}

@end
