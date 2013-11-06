//
//  ODType.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODEntity, ODCollection;
@protocol ODRetrieving;

/// Instance of this object encapsulates an idea of an OData type. At the most basic level, a type can describe a collection
/// or not. Type has a name iff it's not a collection type, so a type should be a  ODType is an abstract type
@interface ODType : NSObject

@property (readonly, getter = isCollection) BOOL collection;
@property (readonly, getter = isPrimitive) BOOL primitive;

@end
