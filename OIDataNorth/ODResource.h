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
@class ODType;
@class ODRetrieveOperation;

/// Public information about properties and methods of ODResource that are common
/// between entities and collections.
@protocol ODResourceAccessing <NSObject>

#pragma mark - (1) how to get a resource

// We can create a resource object by different means.
- (id<ODRetrieving>) retrievalInfo;
- (instancetype)initWithRetrievalInfo:(id<ODRetrieving>)info;

+ (instancetype)resourceWithURL:(NSURL *)URL description:(NSString *)description;
+ (instancetype)resourceWithDict:(id)dict;
+ (instancetype)resourceWithURLString:(NSString *)URLString;
+ (instancetype)resourceWithInfo:(id<ODRetrieving>)info;
+ (instancetype)resourceByURLCopy:(id<ODResourceAccessing>)resource in:(id<ODRetrieving>)parentInfo;

// In any case a resource has an URL and a description.
@property (readonly, nonatomic) NSURL *URL;

#pragma mark - (2) information about the resource

// A resource is either an entity, or collection, or to be determined.
@property (nonatomic) ODResourceKind kind;

// This is either this entity's entity type or collection's entity type.
@property (nonatomic) ODType *type;


#pragma mark - (3) and (4) values of resource and its children

// @property (readonly) NSDate *retrievedOn;

// The result should respond to |-count| and |-objectAtIndexedSubscript:|.
// For example, for an entity, this will be a real NSArray of properties, but for a collection a proxy class
// that returns entities by those methods.

/// It's non-nil iff resource has been retrieved.
/// = Count for collection, plain value for property.
@property (readonly) id resourceValue;

- (BOOL)isEntitySet;
- (BOOL)isPrimitiveProperty;

// Until at least some info about an entity is retrieved, this is nil.
@property (readonly, atomic) NSArray * childrenArray;

#pragma mark - (5) things that can be done with a resource

/// Generic handler for operations.
- (void)handleOperation:(ODOperation *)operation;

/// Retrieving is the most important action for a resource.
- (void)retrieve;
- (ODRetrieveOperation *)retrieveOperation;

/// This is used to retrieve a resource once, but not more then once.
@property BOOL automaticallyRetrieve;
- (instancetype)autoretrieve;

/// This erases known data, but keeps type information.
- (void)clean; // forget, clean, drop, unretrieve, nullify, break, free, unload?

/// Short description incldes only human-readable name, ideally 10-30 characters in length.
- (NSString *)shortDescription;

/// Medium description includes also type and URL.
- (NSString *)description;

/// Long description aims to disclose complete inner state of an object.
- (NSString *)longDescription;

@end



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


