//
//  OIDataCollection.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollection.h"
#import "ODEntity.h"
#import "ODQueryOperation.h"
#import "ODCountOperation.h"

#import "ODEntityRetrieval.h"

@implementation ODCollection {
    ODResource *_parent;
    NSString *_name;
}

- (ODResource *)parent {
    return _parent;
}

- (void)setParent:(ODResource *)parent {
    _parent = parent;
}

- (NSString *)relativePath {
    return self.name;
}

+ (instancetype)collectionForProperty:(NSString *)propertyName entityType:(ODEntityType *)entityType inEntity:(ODEntity *)entity {
    ODCollection *collection = [[self alloc] initWithName:propertyName inParent:entity];
    collection.entityType = entityType;
    return collection;
}

- (instancetype)initWithName:(NSString *)name inParent:(ODResource *)parent {
    self = [super init];
    if (self) {
        _parent = parent;
        _name = name;
    }
    return self;
}

- (ODEntity *)objectForKey:(id)keys {
//    ODEntity *entry = [[ODEntity alloc] initWithParent:self];
//    return entry;
    return nil;
}

- (void)countAndPerform:(void (^)(NSUInteger))block {
    ODCountOperation *operation = [ODCountOperation new];
    operation.resource = self;
    operation.onSuccess = ^(ODOperation *op) {
        if (block) block([(ODCountOperation *)op responseCount]);
    };
    [operation start];
}


- (void)list:(NSUInteger)top from:(NSUInteger)skip expanding:(NSString *)expanding perform:(void (^)(NSArray *))block {
    ODQueryOperation *operation = [ODQueryOperation new];
    operation.resource = self;
    operation.top = top;
    operation.skip = skip;
    operation.expand = expanding;
    operation.onSuccess = ^(ODOperation *op) {
        if (block) block([(ODQueryOperation *)op responseResults]);
    };
    [operation start];
}

- (NSURL *)URL {
    return [NSURL URLWithString:[self relativePath] relativeToURL:[self parent].URL];
}

- (ODEntity *)objectAtIndexedSubscript:(NSUInteger)index {
    ODEntity *entity = [self.entityType createEntity];

    ODEntityRetrievalByIndex *retrieval = [ODEntityRetrievalByIndex new];
    retrieval.collection = self;
    retrieval.index = index;
    entity.retrievalInfo = retrieval;
    
    return entity;
}

- (void)retrieveCount {
    [self.readManager retrieveCount: self];
}

@end
