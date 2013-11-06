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
#import "ODCollectionType.h"
#import "ODNominalTypeProxy.h"

@interface ODTypeLibrary ()
@end

@implementation ODTypeLibrary {
    NSMutableDictionary *_typesByName;
    NSMutableDictionary *_associationEnds;
}

+ (ODTypeLibrary *)shared {
    static ODTypeLibrary *shared;
    if (!shared) shared = [self new];
    return shared;
}

- (id)init {
    if (self = [super init]) {
        _typesByName = [NSMutableDictionary new];
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
    _typesByName[type.name] = type;
    _typesByName[type.primitiveName] = type;
}

- (void)addTypesByName:(NSSet *)objects {
    for (ODNominalType *object in objects) {
        [self addTypesByNameObject:object];
    }
}

- (void)addTypesByNameObject:(ODNominalType *)type {
    id old = _typesByName[type.name];
    if (old && [old respondsToSelector:@selector(setImplementation:)]) {
        [(ODNominalTypeProxy *)old setImplementation:type];
    }
    _typesByName[type.name] = type;
}

- (void)addAssociationEndsObject:(ODAssociationEnd *)end {
    _associationEnds[end.key] = end;
}

- (ODNominalType *)uniqueTypeFor:(NSString *)typeName {
    if (!typeName) return nil;
    
    ODNominalType *result = _typesByName[typeName];
    if (!result) {
        result = [[ODNominalTypeProxy alloc] initWithName:typeName];
        _typesByName[typeName] = result;
    }
    
    return result;
}

- (ODType *)uniqueTypeFor:(NSString *)typeName collection:(BOOL)collection {
    ODType *type = [self uniqueTypeFor:typeName];
    if (!collection) return type;
    return [ODCollectionType collectionWithElements:type];
}

@end
