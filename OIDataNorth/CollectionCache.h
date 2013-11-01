//
//  ODCachedCollection.h
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollection.h"

// Some other things we can do. Note we still can't insert or delete objects. Also, those methods are only accessible
// from a delegate.


@class CollectionCache;

@protocol ODCollectionCacheDelegate
- (void)cache:(CollectionCache *)mutableCache missingObjectAtIndex:(NSUInteger)index;
@end

/// The backing store is changed to a pointer array. Also, it autoexpands.
@interface CollectionCache : NSArray
@property (readonly, weak) id<ODCollectionCacheDelegate> delegate;

- (instancetype)initWithDelegate:(id<ODCollectionCacheDelegate>)delegate;
- (instancetype)initWithDelegate:(id<ODCollectionCacheDelegate>)delegate contents:(NSArray *)array;

// The standard NSArray methods.
- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;

// Actually we can set count at will
@property NSUInteger count;

// As well as replace objects.
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

/// Returns all non-nil objects.
- (NSArray *)allObjects;

/// Drops the internal storage.
- (void)clean;


@end
