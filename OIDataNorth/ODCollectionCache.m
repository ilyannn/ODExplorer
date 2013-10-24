//
//  ODCachedCollection.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollectionCache.h"
#import "ODCollection.h"
#import "ODEntityType.h"
#import "ODEntityRetrieval.h"
#import "ODCountOperation.h"

@interface ODCollectionCache ()
@property NSUInteger count;
@end

@implementation ODCollectionCache {
    NSMutableDictionary *_objects;
    NSUInteger _count;
    BOOL retrieving;
}

- (id)init
{
    self = [super init];
    if (self) {
        _objects = [NSMutableDictionary new];
    }
    return self;
}

- (NSUInteger)batchSize {
    return 20;
}

- (void)performCount {
    return [self.collection countAndPerform:^(NSUInteger count) {
        self.count = count;
    }];
}

- (ODEntity *)objectAtIndexedSubscript:(NSUInteger)index {

    ODEntity *entity = _objects[@(index)];
//    if ([[NSNull null] isEqual:entity]) return nil;
    if (entity) return entity;
    entity = [self.collection.entityType createEntity];

    ODEntityRetrievalByIndex *retrieval = [ODEntityRetrievalByIndex new];
    retrieval.collection = self.collection;
    retrieval.index = index;
    entity.retrievalInfo = retrieval;

    __block NSArray *results;
    
    [self.collection list:self.batchSize from:index expanding:self.expand perform:^(NSArray *items) {
        results = items;
    }];
    
    [results enumerateObjectsUsingBlock:^(ODEntity *obj, NSUInteger resultIndex, BOOL *stop) {
        _objects[@(index + resultIndex)] = obj;
    }];
    
    NSInteger start = !results ? 0 : results.count;
//    NSInteger empty = self.batchSize - start;
    NSInteger end = index + self.batchSize;
    
    for (NSUInteger emptyIndex = index + start; emptyIndex < end; emptyIndex++) {
        _objects[@(emptyIndex)] = [NSNull null];
    }
    
    return results.firstObject;
    
    //return entity;
}


@end
