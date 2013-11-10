//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LazyMutableArray;

/// Delegate is expected to do some magic so that values appear in the array.
@protocol LazyMutableArrayDelegate
/// The returned range will be used to fill in array[index], array[index+1],...
/// At least one element MUST be returned.
- (NSArray *)array:(LazyMutableArray *)lazy missingObjectsFromIndex:(NSUInteger)index;
@end

/// We need to subclass an NSArray because this implementation should be able to change its
/// memory footprint dynamically.
@interface LazyMutableArray : NSMutableArray

/// Delegate is to be set at initialization.
@property (readonly, weak) id<LazyMutableArrayDelegate> delegate;

- (instancetype)initWithDelegate:(id<LazyMutableArrayDelegate>)delegate; /* designated initializer */
- (instancetype)initWithDelegate:(id<LazyMutableArrayDelegate>)delegate contents:(NSArray *)array;

// The standard NSArray methods.
@property (readonly) NSUInteger count;
- (id)objectAtIndex:(NSUInteger)index __attribute__((ns_returns_autoreleased));

// NSMutableArray methods
- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

/// With this class we can set count at will.
- (void)setCount:(NSUInteger)count;

/// Size of currently held contents.
@property NSUInteger size;

// / We can replace objects using [] syntax.
// - (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

/// Drops the internal storage.
- (void)clean;

/// Drops elements that have no other strong references to them. This is done by
/// removing and inserting back elements of the array one-by-one.
- (void)cleanWeakElements;

@end
