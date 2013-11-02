//
//  ODEdmInt.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEdmInt.h"

@implementation ODEdmInt

+ (instancetype)withBits:(NSUInteger)bits {
    return [[self alloc] initWithBits:bits];
}

- (id)initWithBits:(NSUInteger)bits {
    if (self = [super initWithName:[NSString stringWithFormat:@"Int%lu", (long)bits]]) {
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
