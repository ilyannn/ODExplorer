//
//  ODTypeLibrary.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODType, ODAssociationEnd;

@interface ODTypeLibrary : NSObject

+ (ODTypeLibrary *)shared;

@property (readonly) NSDictionary *types;
@property (readonly) NSDictionary *associationEnds;

- (void)addTypesObject:(ODType *)type;
- (void)addAssociationEndsObject:(ODAssociationEnd *)end;

/// This returns an existing class or creates new one. Guaranteed to not return nil.
- (ODType *)uniqueTypeFor:(NSString *)typeName;
- (ODType *)uniqueTypeFor:(NSString *)typeName collection:(BOOL)collection;


@end
