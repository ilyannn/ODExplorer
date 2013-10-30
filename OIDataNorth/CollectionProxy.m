//
//  ODCachedCollection.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "CollectionProxy.h"
#import "ODCollection.h"
#import "ODEntityType.h"
#import "ODEntityRetrieval.h"
#import "ODCountOperation.h"
#import "ODEntity.h"

@interface CollectionProxy ()
@property NSPointerArray *objects;
@end

@implementation CollectionProxy {
    BOOL retrieving;
}

- (id)init {
    self = [super init];
    if (self) {
        [self clean];
    }
    return self;
}

- (void)clean {
    _objects = [NSPointerArray weakObjectsPointerArray];
}

- (NSUInteger)count {
    return self.objects.count;
}

-(void)setCount:(NSUInteger)count {
    @synchronized(self) {
        self.objects.count = count;
    }
}

- (NSArray *)allObjects {
    return [[self objects] allObjects];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    @synchronized(self) {
        if (index >= self.count ) return nil;
        ODEntity *entity = [self.objects pointerAtIndex:index];
        if (entity) return entity;
    }
    
    [self.delegate cache:self missingObjectAtIndex:index];

    @synchronized(self) {
        if (index >= self.count) return nil;
        return [self.objects pointerAtIndex:index];
    }
}

- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    @synchronized(self) {
        if (index < self.count) {
            [self.objects replacePointerAtIndex:index withPointer:(__bridge void *)(object)];
        }
    }
}



@end
