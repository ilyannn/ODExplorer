//
//  ODResourceAccessing.h
//  OIDataNorth
//
//  Created by ilya on 11/7/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

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
