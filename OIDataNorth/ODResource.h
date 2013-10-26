//
//  OIDataResource.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODManagingProtocols.h"

#import "ODRetrievalInfo.h"
#import "ODEntityType.h"

typedef NS_ENUM (NSInteger, ODResourceKind) {
    ODResourceKindUnknown = 0,
    ODResourceKindEntity,
    ODResourceKindCollection
};


// The fundamental dichotonomy between resources; a resource is either best represented with a dictionary (entity-kind), or
// with array (collection-kind). Here property is an entity with a standard type and service is a collection (albeit non-standard
// in the sense that it contains collections).

// Kind can be changed in the following situations:
//   * retrieving: we know from JSON about kind;
//   * creating from a subclass: the kind will be automatically set;
//   * following links if we know the servive model;
//   * manually, by setting a property.
//
// This should be set before any non-trivial operations. Also, it's not possible to set this value more than once. For
// example, an object of |ODEntity| class will under no circumstances behave as a collection. Retrieving an object will
// set it the first time, but always validate against kind.

// An ODResource is using memory for the following infoation --
//   (1) how to get an object (|retrievalInfo|)
//   (2) whether it's an entity or a collection and what type is the object
//   (3) properties of an entity, collection count -- always stored strongly; something you can change
//   (4) cached children, if they are strongly held by someone else
// A resource can't exist without information about its retrieval, so it's not possible to get
// rid of (1). It's trivial to get rid of (4) by not keeping the returned pointer.
// One can drop information (3) about the resource by calling -clean. It's not possible to
// get rid of (2) except by creating a new object.


@class ODResource, ODCollection, ODEntity, ODEntitySet;


@protocol ODResourceAccessing <NSObject>

// We can create a resource object by different means.
@property (nonatomic) ODRetrievalInfo *retrievalInfo;
+ (instancetype)resourceWithURL:(NSURL *)URL description:(NSString *)description;
- (instancetype)initWithRetrievalInfo:(ODRetrievalInfo *)info;

// This is the most important action for a resource.
- (void)retrieve;

// Drop known data, but keep type information.
- (void)clean; // forget, clean, drop, unretrieve, nullify, break, free, unload

// In any case a resource has an URL and a description.
@property (readonly, nonatomic) NSURL *URL;

// Short description incldes only human-readable name, ideally 10-30 characters in length.
- (NSString *)shortDescription;

// Medium description includes also type and URL.
- (NSString *)description;

// Long description aims to disclose complete inner state of an object.
- (NSString *)longDescription;

// A resource is either an entity, or collection, or to be determined.
@property (nonatomic) ODResourceKind kind;

// This is either this entity's entity type or collection's entity type.
@property (nonatomic) ODEntityType *entityType;

// This property will be re-computed every time if not stored strongly.
// The result should respond to |-count| and |-objectAtIndexedSubscript:|.
// For example, for an entity, this will be a real NSArray, but for a collection a proxy class
// that returns entities by those methods.
@property __weak id childrenArray;

// Managers come from |retrievalInfo| hierarchy.
- (id <ODFaultManaging> )readManager;
- (id <ODChangeManaging> )changeManager;

@end


/// This class implements all of functionality for resources, but declares only the base part.
@interface ODResource : NSObject <ODResourceAccessing>

@end
