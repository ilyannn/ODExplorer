//
//  ODElementType.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODNominalType.h"

@implementation ODNominalType

- (NSString *)name {
    return nil;
}

- (id)valueForJSONObject:(id)obj {
    return obj;
}

- (NSString *)description {
    return [self name];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@{name = %@}", [super description], [self name]];
}

- (BOOL)isEqual:(ODNominalType *)object {
    return [object isKindOfClass:[ODNominalType class]] && [self.name isEqual:object.name];
}

- (NSUInteger)hash {
    return [self.name hash] + 1;
}

- (NSString *)primitiveName {
    return nil;
}

@end
