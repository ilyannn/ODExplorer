//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class LazyMutableArray;

/// Delegate is expected to do some magic so that values appear in the array.
@protocol ODCollectionCacheDelegate
- (void)array:(LazyMutableArray *)lazy missingObjectAtIndex:(NSUInteger)index;
@end

/// We need to subclass an NSArray because the backing store is a pointer array which can expand dynamically.
@interface LazyMutableArray : NSMutableArray

/// Delegate is to be set at initializationd.
@property (readonly, weak) id<ODCollectionCacheDelegate> delegate;

- (instancetype)initWithDelegate:(id<ODCollectionCacheDelegate>)delegate; /* designated initializer */
- (instancetype)initWithDelegate:(id<ODCollectionCacheDelegate>)delegate contents:(NSArray *)array;

// The standard NSArray methods.
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)count;


// NSMutableArray methods
- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

/// With this class we can set count at will.
- (void)setCount:(NSUInteger)count;


/// We can replace objects using [] syntax.
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

/// Drops the internal storage.
- (void)clean;


@end
