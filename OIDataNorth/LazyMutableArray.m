//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "LazyMutableArray.h"

@implementation LazyMutableArray {
    NSPointerArray *_objects; // Created lazily, only on -setCount:, insert/add object.
}

- (id)init {
    return [self initWithDelegate:nil];
}

- (id)initWithDelegate:(id<LazyMutableArrayDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}

- (id)initWithDelegate:(id<LazyMutableArrayDelegate>)delegate contents:(NSArray *)array {
    if (self = [self initWithDelegate:delegate]) {
        self.count = [array count];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            self[idx] = obj;
        }];
    }
    return self;
}

- (void)createObjects {
    if (!_objects) {
        _objects = [NSPointerArray strongObjectsPointerArray];
    }
}

- (void)clean {
    _objects = nil;
}

- (NSUInteger)count {
    return _objects.count;
}

-(void)setCount:(NSUInteger)count {
    @synchronized(self) {
        if (!!count) [self createObjects];
        _objects.count = count;
    }
}

- (id)objectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        if (index >= self.count) {
            return nil;
        }
        __weak id object = [_objects pointerAtIndex:index];
        if (object) {
            return object;
        }
    }
    
    [self.delegate array:self missingObjectAtIndex:index];

    @synchronized(self) {
        if (index >= self.count) {
            return nil;
        }
        __weak id object = [_objects pointerAtIndex:index];
        if (object) {
            return object;
        }
    }
    @throw([NSException exceptionWithName:NSObjectNotAvailableException
                                   reason:@"Delegate was not able to provide a non-nil element to a lazy array"
                                 userInfo:nil]);
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {;
    @synchronized(self) {
        if (index < self.count) {
            [_objects replacePointerAtIndex:index withPointer:(__bridge void *)(anObject)];
        }
    }
}

- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    [self replaceObjectAtIndex:(NSUInteger)index withObject:(id)object];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self createObjects];
    [_objects insertPointer:(__bridge void*)anObject atIndex:index];
}

- (void)addObject:(id)anObject {
    [self createObjects];
    [_objects addPointer:(__bridge void*)anObject];
}

- (void)removeLastObject {
    if (_objects.count) {
        [_objects removePointerAtIndex:_objects.count - 1];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [_objects removePointerAtIndex:index];
}

- (void)cleanWeakElements {
    for (NSUInteger index = 0; index < _objects.count; index ++) {
        __weak id pointer = [_objects pointerAtIndex:index];
        if (pointer) [_objects replacePointerAtIndex:index withPointer:nil];
        if (pointer) [_objects replacePointerAtIndex:index withPointer:(__bridge void*)pointer];
    }
}

@end
