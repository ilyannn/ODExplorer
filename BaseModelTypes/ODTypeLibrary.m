//
//  ODTypeLibrary.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODTypeLibrary.h"

#import "ODAssociationEnd.h"
#import "ODCollectionType.h"
#import "ODStructuredType.h"
#import "ODNominalTypeProxy.h"

@interface ODTypeLibrary (BasicTypes)
- (void)nameBasicTypes;
@end

@implementation ODTypeLibrary {
    NSMutableDictionary *_nominalTypes;
    NSMutableDictionary *_associationEnds;
}

+ (ODTypeLibrary *)shared {
    static ODTypeLibrary *shared;
    if (!shared) shared = [self new];
    return shared;
}

- (id)init {
    if (self = [super init]) {
        _associationEnds = [NSMutableDictionary new];
        _nominalTypes = [NSMutableDictionary new];
        [self nameBasicTypes];
    }
    return self;
}

- (void)addNominalTypes:(NSSet *)objects {
    for (ODNominalType *object in objects) {
        [self addNominalTypesObject:object];
    }
}

- (ODCollectionType *)baseCollectionType {
    return [ODCollectionType collectionWithElements:self.baseEntityType];
}

- (void)addNominalTypesObject:(ODNominalType *)type {
    id old = _nominalTypes[type.name];
    if (old && [old respondsToSelector:@selector(setImplementation:)]) {
        [(ODNominalTypeProxy *)old setImplementation:type];
    }
    _nominalTypes[type.name] = type;
    if ([type primitiveName]) {
        _nominalTypes[type.primitiveName] = type;
    }
}

- (void)removeNominalTypesObject:(ODNominalType *)type {
    [_nominalTypes removeObjectForKey:type.name];
    if ([type primitiveName]) {
        [_nominalTypes removeObjectForKey:type.primitiveName];
    }
}

- (void)addAssociationEndsObject:(ODAssociationEnd *)end {
    _associationEnds[end.key] = end;
}

- (ODNominalType *)uniqueTypeFor:(NSString *)typeName {
    if (!typeName) return nil;
    
    ODNominalType *result = _nominalTypes[typeName];
    
    if (!result) {
        result = [[ODNominalTypeProxy alloc] initWithName:typeName];
        _nominalTypes[typeName] = result;
    }
    
    return result;
}

- (ODType *)uniqueTypeFor:(NSString *)typeName collection:(BOOL)collection {
    ODType *type = [self uniqueTypeFor:typeName];
    if (!collection) return type;
    return [ODCollectionType collectionWithElements:type];
}

@end


#import "ODType+Primitive.h"
#import "ODPrimitiveTypeUnknown.h"

@implementation ODTypeLibrary (BasicTypes)

- (void)nameBasicTypes {
    [self addNominalTypes:[ODType allPrimitiveTypes]];

    _baseEntityType = [[ODStructuredType alloc] initWithName:@"Edm.Entity" properties:nil keys:nil];
    [self addNominalTypesObject:_baseEntityType];

    _unknownPrimitiveType = [ODPrimitiveTypeUnknown new];
}

@end
