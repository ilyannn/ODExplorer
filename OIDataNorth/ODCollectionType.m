//
//  ODCollectionType.m
//  OIDataNorth
//
//  Created by ilya on 11/5/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollectionType.h"

@implementation ODCollectionType

+ (instancetype)collectionWithElements:(ODNamedType *)elementType {
    return [[self alloc] initWithElementType:elementType];
}

- (instancetype)initWithElementType:(ODNamedType *)elementType {
    if (self = [super init]) {
        _elementType = elementType;
    }
    return self;
}

- (BOOL)isCollection {
    return YES;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Collection(%@)", self.elementType];
}

@end
