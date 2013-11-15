//
//  ODType.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODType.h"

@implementation ODType

- (BOOL)isCollection {
    return NO;
}

- (BOOL)isComplex {
    return NO;
}

- (BOOL)isEntity {
    return NO;
}

- (BOOL)isPrimitive {
    return NO;
}

- (BOOL)isNotImplemented {
    return NO;
}

- (BOOL)hasKeys {
    return NO;
}

- (ODType *)parentType {
    return nil;
}

- (BOOL)isSubtypeOf:(ODType *)parentType {
    for (ODType *ancestor = self; ancestor; ancestor = [ancestor parentType]) {
        if ([self isEqual: parentType]) {
            return YES;
        }
    }
    return NO;
}

@end
