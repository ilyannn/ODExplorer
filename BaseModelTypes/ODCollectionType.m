//
//  ODCollectionType.m
//  OIDataNorth
//
//  Created by ilya on 11/5/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollectionType.h"

@implementation ODCollectionType

+ (instancetype)collectionWithElements:(ODNominalType *)elementType {
    return [[self alloc] initWithElementType:elementType];
}

- (instancetype)initWithElementType:(ODNominalType *)elementType {
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

- (BOOL)isEqual:(ODCollectionType *)object {
    return [object isKindOfClass:[ODCollectionType class]]
           && [self.elementType isEqual:object.elementType];
}

- (NSUInteger)hash {
    return [self.elementType hash] + 1;
}

@end
