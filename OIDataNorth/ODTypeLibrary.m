//
//  ODTypeLibrary.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODTypeLibrary.h"
#import "ODType+Primitive.h"
#import "ODAssociationEnd.h"

@interface ODTypeLibrary ()
@end

@implementation ODTypeLibrary {
    NSMutableDictionary *_types;
    NSMutableDictionary *_associationEnds;
}

+ (ODTypeLibrary *)shared {
    static ODTypeLibrary *shared;
    if (!shared) shared = [self new];
    return shared;
}

- (id)init {
    if (self = [super init]) {
        _types = [NSMutableDictionary new];
        _associationEnds = [NSMutableDictionary new];
        for (ODPrimitiveType *type in [self listPrimitiveTypes])
            [self addPrimitiveType:type];
    }
    return self;
}

- (NSArray *)listPrimitiveTypes {
    return [ODType listPrimitiveTypes];
}

- (void)addPrimitiveType:(ODPrimitiveType *)type {
    _types[type.name] = type;
    _types[type.primitiveName] = type;
}

- (void)addTypesObject:(ODType *)type {
    _types[type.name] = type;
}

- (void)addAssociationEndsObject:(ODAssociationEnd *)end {
    _associationEnds[end.key] = end;
}

- (ODType *)uniqueTypeFor:(NSString *)typeName {
    if (!typeName) return nil;
    
    ODType *result = _types[typeName];
    if (!result) {
        result = [[ODType alloc] initWithName:typeName];
        _types[typeName] = result;
    }
    
    return result;
}

@end
