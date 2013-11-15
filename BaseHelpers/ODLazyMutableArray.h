//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODLazyMutableArray;

/// Delegate is expected to do some magic so that values appear in the array.
@protocol ODLazyMutableArrayDelegate

/// The returned range will be used to fill in array[index], array[index+1],...
/// At least one element must be returned, otherwise an exception is raised.
- (NSArray *)array:(ODLazyMutableArray *)lazy missingObjectsFromIndex:(NSUInteger)index;

@end

/// This class is similar to NSMutableArray (which is in fact used as a backend).
/// However, it can have gaps of "null" values, which are expected to be filled
/// by delegate. It's possible to set a specific element to "null" or change the count.
/// This implementation changes its memory footprint dynamically.
@interface ODLazyMutableArray : NSMutableArray

// Memory semantics for this collection are slightly different compared to
// it parent, NSMutableArray.
// See http://stackoverflow.com/q/19883056/115200 for details.

/// Delegate is to be set at initialization.
/// You can use array without a delegate, but it will result in exception once
/// it becomes necessary.
@property (weak) id<ODLazyMutableArrayDelegate> delegate;

- (instancetype)initWithDelegate:(id<ODLazyMutableArrayDelegate>)delegate; /* designated initializer */
- (instancetype)initWithDelegate:(id<ODLazyMutableArrayDelegate>)delegate contents:(NSArray *)array;

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

/// With this class we can set count at will. Array's contents will shrink if necessary.
- (void)setCount:(NSUInteger)count;

/// Real size of currently held contents.
@property NSUInteger size;

/// Drops elements that have no other strong references to them. This is done by
/// removing and inserting back elements of the array one-by-one.
- (void)cleanWeakElements;

@end
