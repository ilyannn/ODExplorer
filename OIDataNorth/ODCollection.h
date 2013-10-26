//
//  OIDataCollection.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"

@protocol ODCollectionAccessing <ODResourceAccessing>

@end

@class ODEntity, ODEntityType;

@interface ODCollection : ODResource <ODCollectionAccessing>

@property (nonatomic) id<ODRetrievingByPath> retrievalInfo;
@property NSUInteger count;

- (void)retrieveCount;

- (ODEntity *)objectForKey:(id)objectKey;
- (ODEntity *)objectAtIndexedSubscript:(NSUInteger)index;

- (void)countAndPerform:(void (^)(NSUInteger count))block;
- (void)list:(NSUInteger)top from:(NSUInteger)skip expanding:(NSString *)expanding perform:(void (^)(NSArray *items))block
;


+ (instancetype)collectionForProperty:(NSString *)propertyName
                           entityType:(ODEntityType *)entityType
                             inEntity:(ODEntity *)entity;

@end
