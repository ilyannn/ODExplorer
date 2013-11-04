//
//  ODRetrievalInfo.h
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODManaging.h"
#import "ODRetrieving.h"

/// Base class to retrieve information about a resource within a context.
/// It is kind of abstract. Since the URL is nil and can't be changed, the only
/// way to get something useful from object of this class is by setting a non-trivial parent.
/// So directly instantiating ODRetrievalInfo with a parent is a way to create a separate copy of the resource.
@interface ODRetrievalInfo : NSObject <ODRetrieving>

+ (ODRetrievalInfo *)sharedRoot;
+ (void)setSharedRoot:(ODRetrievalInfo *)info;

@property id<ODRetrieving> parent;
@property NSURL *knownURL;

- (void)addManager:(id<ODManaging>)manager;
@property (readonly) NSArray *managers;

- (ODType *)metadataType;
@property ODMetadataModel *metadataModel;
- (ODMetadataOperation *)metadataOperation;
- (void)retrieveMetadata;

@end

// You have to retrieve at least something by URL. This class encapsulates an idea of retrieval
// where the information - URL and description - are set manually.
@interface ODRetrievalByURL : ODRetrievalInfo

@property NSURL *URL;
@property NSString *shortDescription;

@end

// Going from the root down, you can retrieve by relative path.
@protocol ODRetrievingByPath <ODRetrieving>
- (NSString *)relativePath;
@end

// This is also a class with some abstract methods.
@interface ODRetrievalByPath : ODRetrievalInfo <ODRetrievingByPath>
@end

// For example, a path can be a property name.
@interface ODRetrievalOfProperty : ODRetrievalByPath
@property NSString *propertyName;
@end

// Or the path can belong to an entity set, in which case you can also provide separate description.
@interface ODRetrievalOfEntitySet : ODRetrievalByPath
@property NSString *shortDescription;
@property NSString *entitySetPath;
@end

// Sometimes we can retrieve by adding brackets to the existing URL.
// This is possible only if the parent conforms to a stricter protocol.
@interface ODRetrievalByBrackets : ODRetrievalInfo
@property id<ODRetrievingByPath> parent;
- (NSString *)bracketPart;
@end

// Inside the brackets could be an index in the collection.
@interface ODRetrievalByIndex : ODRetrievalByBrackets
@property NSUInteger index;
@end

// Or those could be keys to select from entity set.
@interface ODRetrievalByKeys : ODRetrievalByBrackets
- (NSDictionary *)keys;
@end

// Here we have a nice fuzzy instance of dictionary created for us.
@interface ODRetrievalByMutableKeys : ODRetrievalByBrackets
@property NSMutableDictionary *keys;
@end



