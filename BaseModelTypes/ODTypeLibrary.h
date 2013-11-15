//
//  ODTypeLibrary.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"
#import "ODCollectionType.h"
#import "ODStructuredType.h"

@class ODAssociationEnd;

@interface ODTypeLibrary : NSObject

+ (ODTypeLibrary *)shared;

@property (readonly) NSDictionary *nominalTypes;
@property (readonly) NSDictionary *associationEnds;

@property (readonly) ODStructuredType *baseEntityType;
@property (readonly) ODCollectionType *baseCollectionType;
@property (readonly) ODPrimitiveType *unknownPrimitiveType;

- (void)addNominalTypes:(NSSet *)objects;
- (void)addNominalTypesObject:(ODNominalType *)type;
- (void)addAssociationEndsObject:(ODAssociationEnd *)end;

/// This returns an existing class or creates an instance of ODUnknownNamedType.
- (ODNominalType *)uniqueTypeFor:(NSString *)typeName;

/// This returns an existing named class or collection.
- (ODType *)uniqueTypeFor:(NSString *)typeName collection:(BOOL)collection;

@end
