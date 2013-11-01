//
//  ODCachedCollection.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "CollectionCache.h"
#import "ODCollection.h"
#import "ODEntityType.h"
#import "ODEntityRetrieval.h"
#import "ODCountOperation.h"
#import "ODEntity.h"

@implementation CollectionCache {
    NSPointerArray *_objects;
}

- (id)init {
    if (self = [super init]) {
        [self clean];
    }
    return self;
}

- (id)initWithDelegate:(id<ODCollectionCacheDelegate>)delegate {
    if (self = [self init]) {
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
    _objects = [NSPointerArray strongObjectsPointerArray];
}

- (NSUInteger)count {
    return _objects.count;
}

-(void)setCount:(NSUInteger)count {
    @synchronized(self) {
        _objects.count = count;
    }
}

- (NSArray *)allObjects {
    return [_objects allObjects];
}

- (id)objectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        if (index >= self.count ) return nil;
        ODEntity *entity = [_objects pointerAtIndex:index];
        if (entity) return entity;
    }
    
    [self.delegate cache:self missingObjectAtIndex:index];

    @synchronized(self) {
        if (index >= self.count) return nil;
        return [_objects pointerAtIndex:index];
    }
}

- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    @synchronized(self) {
        if (index < self.count) {
            [_objects replacePointerAtIndex:index withPointer:(__bridge void *)(object)];
        }
    }
}



@end
