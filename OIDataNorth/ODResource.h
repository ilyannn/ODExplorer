//
//  OIDataResource.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODManaging.h"
#import "ODRetrieving_Protocol.h"
@class ODStructuredType;

typedef NS_ENUM (NSInteger, ODResourceKind) {
    ODResourceKindUnknown = 0,
    ODResourceKindEntity,
    ODResourceKindCollection
};


// Fundamentally resource is either best represented with a dictionary (entity-kind), or
// with array (collection-kind). Here property is an entity with a standard type and service
// is a collection (albeit non-standard in the sense that it contains collections).

// Kind can be changed in the following situations:
//   * retrieving: we know from JSON about kind;
//   * creating from a subclass: the kind will be automatically set;
//   * following links if we know the servive model;
//   * manually, by setting a property.
//
// This should be set before any non-trivial operations. Also, it's not possible to set this value more than once. For
// example, an object of |ODEntity| class will under no circumstances behave as a collection. Retrieving an object will
// set it the first time, but always validate against kind.



@class ODResource, ODCollection, ODEntity, ODEntitySet;

#import "ODResourceAccessing.h"

/// This class implements all of functionality for resources, but declares only the base part.

/// An ODResource is using memory for the following infoation --
///   (1) how to get an object (-retrievalInfo)
///   (2) type - whether it's an entity or a collection and what type is the object
///   (3) values - retrieved date, properties of an entity, collection count
///   (4) cached children, if they are strongly held by someone else
/// A resource can't exist without information about its retrieval, so it's not possible to get
/// rid of (1). It's trivial to get rid of (4) by not keeping the returned pointer.
/// One can drop information (3) about the resource by calling -clean. It's not possible to
/// get rid of (2) except by creating a new object.

@interface ODResource : NSObject <ODResourceAccessing>

// Use +new or +unique initializer in subclasses if you defined +resourceDict.
+ (instancetype)new;
+ (instancetype)unique;

+ (NSDictionary *)resourceDict;

// Values of resources are weakly held in a global table. The key is [self resourceDict].
+ (instancetype)uniqueWithDict:(NSDictionary *)dict;

@property BOOL automaticallyRetrieve;
@property (nonatomic) ODResourceKind kind;
@property (nonatomic) ODType *type;

@end


