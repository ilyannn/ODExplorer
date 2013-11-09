//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LazyMutableArray;

/// Delegate is expected to do some magic so that values appear in the array.
@protocol LazyMutableArrayDelegate
- (void)array:(LazyMutableArray *)lazy missingObjectAtIndex:(NSUInteger)index;
@end

/// We need to subclass an NSArray because the backing store is a pointer array which can expand dynamically.
@interface LazyMutableArray : NSMutableArray

/// Delegate is to be set at initializationd.
@property (readonly, weak) id<LazyMutableArrayDelegate> delegate;

- (instancetype)initWithDelegate:(id<LazyMutableArrayDelegate>)delegate; /* designated initializer */
- (instancetype)initWithDelegate:(id<LazyMutableArrayDelegate>)delegate contents:(NSArray *)array;

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

/// Drops elements that have no strong references to them. This is done by converting internal
/// storage to use weak elements.
- (void)cleanWeakElements;

@end
