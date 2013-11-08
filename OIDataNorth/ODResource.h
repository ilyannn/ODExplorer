//
//  OIDataResource.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource_Protocol.h"

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

@interface ODResource : NSObject <ODResource>

// Use +new or +unique initializer in subclasses if you defined +resourceDict.
+ (instancetype)new;
+ (instancetype)unique;

+ (instancetype)resourceWithURL:(NSURL *)URL description:(NSString *)description;
+ (instancetype)resourceWithDict:(id)dict;
+ (instancetype)resourceWithURLString:(NSString *)URLString;
+ (instancetype)resourceWithInfo:(id<ODRetrieving>)info;
+ (instancetype)resourceByURLCopy:(id<ODResource>)resource in:(id<ODRetrieving>)parentInfo;
- (instancetype)initWithRetrievalInfo:(id<ODRetrieving>)info;

+ (NSDictionary *)resourceDict;

// Values of resources are weakly held in a global table. The key is [self resourceDict].
+ (instancetype)uniqueWithDict:(NSDictionary *)dict;

@property BOOL automaticallyRetrieve;
@property (nonatomic) ODResourceKind kind;
@property (nonatomic) ODType *type;

@end


