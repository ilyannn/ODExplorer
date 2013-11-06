//
//  ODUnknownNamedType.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODNominalTypeProxy.h"

@implementation ODNominalTypeProxy {
    NSString *_name;
}

- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

- (NSString *)name {
    return _name;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.implementation;
}

- (NSString *)description {
    if (self.implementation)
        return [self.implementation description];
    else
        return [NSString stringWithFormat: @"%@(no implementation)", [super description]];
}

- (BOOL)isNotImplemented {
    return !self.implementation;
}

@end
