//
//  ODType.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODType.h"

@implementation ODType


// Can't create without a name.
- (id)init {
    return nil;
}

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

- (NSString *)description {
    return self.name;
}

- (BOOL)isPrimitive {
    return NO;
}

- (id)valueForJSONObject:(id)obj {
    return obj;
}

@end
