//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODHLazyMutableArray.h"

@implementation ODHLazyMutableArray {
    NSMutableArray *_objects; // Created lazily, only on -setCount:, insert/add object.
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
        _count = [array count];
        _objects = [array mutableCopy];
    }
    return self;
}

- (void)clean {
    self.count = 0;
}

- (void)setCount:(NSUInteger)count {
    if (self.size > count) {
        self.size = count;
    }
    _count = count;
}

- (NSUInteger)size {
    return _objects.count;
}

- (void)growTo:(NSUInteger)size {
    if (!_objects && size) {
        _objects = [NSMutableArray new];
    }
    
    id singleton = [self singleton];
    while (_objects.count < size) {
        [_objects addObject:singleton];
    }
    
    NSAssert(self.size >= size, @"We didn't grow contents correctly, it seems.");
}

- (void)setSize:(NSUInteger)size {
    if (_objects.count < size) {
        [self growTo:size];
    }
    
    if (_objects && !size) {
        _objects = nil;
    }
    if (_objects.count > size) {
        NSRange range = NSMakeRange(size, _objects.count - size);
        [_objects removeObjectsInRange:range];
    }
    NSAssert(self.size == size, @"We didn't set the size correctly, it seems.");
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }

    id singleton = [self singleton];

    @autoreleasepool {
        [self growTo:index + 1];
        
        __weak id object  = _objects[index];
        
        if (object != singleton) {
            return object;
        }
        
    }
    NSArray *missing = [self.delegate array:self missingObjectsFromIndex:index];
    if (!missing.count) {
        @throw([NSException exceptionWithName:NSObjectNotAvailableException
                                       reason:@"Delegate was not able to provide a non-nil element to a lazy array"
                                     userInfo:nil]);
    }

    [missing enumerateObjectsUsingBlock:^(id obj, NSUInteger jdx, BOOL *stop) {
        if (index + jdx >= _objects.count || _objects[index + jdx] == singleton) {
            _objects[index + jdx] = obj;
        }
    }];
    
    return _objects[index];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= self.count) {
        return;
    }
    
    [self growTo:index];
    
    if (index == _objects.count) {
        [_objects addObject:anObject];
    } else {
        [_objects replaceObjectAtIndex:index withObject:anObject];
    }
}

//- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
//    [self replaceObjectAtIndex:(NSUInteger)index withObject:(id)object];
//}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index != self.count) {
        @throw([NSException exceptionWithName:NSRangeException
                                       reason:@"This class does not support inserting element except at the end"
                                     userInfo:nil]);
    }
    [self addObject:anObject];
}

- (void)addObject:(id)anObject {
    self.size = _count;
    if (!_objects) {
        _objects = [NSMutableArray new];
    }
    [_objects addObject:anObject];
    _count++;
    NSAssert(self.count == self.size, @"After adding an object, array should be completely full");
}

- (void)removeLastObject {
    self.count--;
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    if (index != self.count) {
        @throw([NSException exceptionWithName:NSRangeException
                                       reason:@"This class does not support removing element except at the end"
                                     userInfo:nil]);
    }
    [self removeLastObject];
}

- (id)singleton {
    static id singleton;
    if (!singleton) {
        singleton = [NSValue valueWithPointer:&singleton];
    }
    return singleton;
}

- (void)cleanWeakElements {
    id singleton = [self singleton];
    for (NSUInteger index = 0; index < _objects.count; index ++) {
        __weak id obj = _objects[index];
        if (obj != singleton) {
            // If this was the only strong reference, obj is deallocated here.
            _objects[index] = singleton;
            if (obj) _objects[index] = obj;
        }
    }
}

@end
