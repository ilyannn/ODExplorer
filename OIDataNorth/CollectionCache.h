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

/// Delegate is expected to do some magic so that values appear in the array.
@protocol ODCollectionCacheDelegate
- (void)cache:(CollectionCache *)mutableCache missingObjectAtIndex:(NSUInteger)index;
@end

/// We need to subclass an NSArray because the backing store is a pointer array which can expand dynamically.
@interface CollectionCache : NSArray

/// Once set, delegate doesn't change.
@property (readonly, weak) id<ODCollectionCacheDelegate> delegate;

@property NSMutableArray *xx;

- (instancetype)initWithDelegate:(id<ODCollectionCacheDelegate>)delegate; /* designated initializer */
- (instancetype)initWithDelegate:(id<ODCollectionCacheDelegate>)delegate contents:(NSArray *)array;

// The standard NSArray methods.
- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;

/// With this class we can set count at will.
@property NSUInteger count;

/// We can replace, but not insert or remove, objects.
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

/// We can replace objects using [] syntax.
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

/// Drops the internal storage.
- (void)clean;


@end