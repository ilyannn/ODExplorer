//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODHLazyMutableArray;

/// Delegate is expected to do some magic so that values appear in the array.
@protocol LazyMutableArrayDelegate

/// The returned range will be used to fill in array[index], array[index+1],...
/// At least one element must be returned, otherwise an exception is raised.
- (NSArray *)array:(ODHLazyMutableArray *)lazy missingObjectsFromIndex:(NSUInteger)index;

@end

/// This class is similar to NSMutableArray, which is in fact used as a backend.
/// However, it can have gaps of "null" values, which are expected to be filled
/// by delegate.
/// It's also possible to set element a specific element to "null".
/// This implementation changes its memory footprint dynamically.
@interface ODHLazyMutableArray : NSMutableArray

/// Delegate is to be set at initialization.
/// You can use array without a delegate, but it will result in exception once
/// it becomes necessary.
@property (weak) id<LazyMutableArrayDelegate> delegate;

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

/// anObject can be nil
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

/// With this class we can set count at will.
- (void)setCount:(NSUInteger)count;

/// Real size of currently held contents.
@property NSUInteger size;

// / We can replace objects using [] syntax.
// - (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

/// Drops the internal storage.
- (void)clean;

/// Drops elements that have no other strong references to them. This is done by
/// removing and inserting back elements of the array one-by-one.
- (void)cleanWeakElements;

@end
