//
//  ODCachedCollection.h
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollection.h"

@class CollectionCache;
@protocol ODCollectionCacheDelegate
- (void)cache:(CollectionCache *)cache missingObjectAtIndex:(NSUInteger)index;
@end

@interface CollectionCache : NSObject
@property __weak id<ODCollectionCacheDelegate> delegate;

@property NSUInteger count;
- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

- (void)clean;

/// Returns all non-nil objects.
- (NSArray *)allObjects;

@end
