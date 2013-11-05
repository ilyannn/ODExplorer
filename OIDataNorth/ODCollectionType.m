//
//  ODCollectionType.m
//  OIDataNorth
//
//  Created by ilya on 11/5/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollectionType.h"

@implementation ODCollectionType

+ (instancetype)collectionWithElements:(ODType *)elementType {
    return [[self alloc] initWithElementType:elementType];
}

- (instancetype)initWithElementType:(ODType *)elementType {
    if (self = [super initWithName:elementType.name]) {
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
