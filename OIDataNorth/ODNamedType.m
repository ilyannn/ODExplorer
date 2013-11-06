//
//  ODElementType.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODNamedType.h"

@implementation ODNamedType

- (NSString *)name {
    return nil;
}

- (BOOL)isPrimitive {
    return NO;
}

- (id)valueForJSONObject:(id)obj {
    return obj;
}

- (BOOL)isCollection {
    return NO;
}

@end
