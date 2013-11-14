//
//  ODType.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

/// Instance of this object encapsulates an idea of an OData type. At the most basic level, a type can describe a collection
/// or not. Type has a name iff it's not a collection type, so a type should be a  ODType is an abstract type
@interface ODType : NSObject

// Exactly one of those five should be true.
- (BOOL) isCollection;
- (BOOL) isPrimitive;
- (BOOL) isComplex;
- (BOOL) isEntity;
- (BOOL) isNotImplemented;

- (ODType *)parentType;

- (BOOL) hasKeys;
- (BOOL) isSubtypeOf:(ODType *)parentType;

@end
