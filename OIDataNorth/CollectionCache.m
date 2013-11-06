//
//  ODCachedCollection.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "CollectionCache.h"
#import "ODEntity.h"

@implementation CollectionCache {
    NSPointerArray *_objects; // Created lazily, only on -setCount:
}

- (id)init {
    return [self initWithDelegate:nil];
}

- (id)initWithDelegate:(id<ODCollectionCacheDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}

- (id)initWithDelegate:(id<ODCollectionCacheDelegate>)delegate contents:(NSArray *)array {
    if (self = [self initWithDelegate:delegate]) {
        self.count = [array count];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            self[idx] = obj;
        }];
    }
    return self;
}

- (void)clean {
    _objects = nil;
}

- (NSUInteger)count {
    return _objects.count;
}

-(void)setCount:(NSUInteger)count {
    @synchronized(self) {
        if (!_objects && !!count) _objects = [NSPointerArray strongObjectsPointerArray];;
        _objects.count = count;
    }
}

- (id)objectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        if (index >= self.count) return nil;
        ODEntity *entity = [_objects pointerAtIndex:index];
        if (entity) return entity;
    }
    
    [self.delegate cache:self missingObjectAtIndex:index];

    @synchronized(self) {
        if (index >= self.count) return nil;
        return [_objects pointerAtIndex:index];
    }
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


@end
