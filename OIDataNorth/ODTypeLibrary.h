//
//  ODTypeLibrary.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODType, ODNominalType, ODAssociationEnd;

@interface ODTypeLibrary : NSObject

+ (ODTypeLibrary *)shared;

@property (readonly) NSDictionary *typesByName;
@property (readonly) NSDictionary *associationEnds;

- (void)addTypesByName:(NSSet *)objects;
- (void)addTypesByNameObject:(ODNominalType *)type;
- (void)addAssociationEndsObject:(ODAssociationEnd *)end;

/// This returns an existing class or creates an instance of ODUnknownNamedType.
- (ODNominalType *)uniqueTypeFor:(NSString *)typeName;

/// This returns an existing named class or collection.
- (ODType *)uniqueTypeFor:(NSString *)typeName collection:(BOOL)collection;


@end
