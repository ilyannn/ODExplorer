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
    NSString *_name;
}

// This is a designated initializer.
- (id)init {
    self = [super init];
    if (self) {
        self.kind = ODResourceKindCollection;
    }
    return self;
}

+ (instancetype)collectionForProperty:(NSString *)propertyName entityType:(ODEntityType *)entityType inEntity:(ODEntity *)entity {
    ODCollection *collection = [[self alloc] initWithName:propertyName inParent:entity];
    collection.entityType = entityType;
    return collection;
}

- (instancetype)initWithName:(NSString *)name inParent:(ODResource *)parent {
    self = [self init];
    if (self) {
        
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
    if (block) {
        [operation addOperationStep:^NSError *(ODCountOperation *operation) {
            block(operation.responseCount);
            return nil;
        }];
    }
    [operation start];
}

- (void)list:(NSUInteger)top from:(NSUInteger)skip expanding:(NSString *)expanding perform:(void (^)(NSArray *))block {
    ODQueryOperation *operation = [ODQueryOperation new];
    operation.resource = self;
    operation.top = top;
    operation.skip = skip;
    operation.expand = expanding;
    if (block) {
        [operation addOperationStep:^NSError *(ODQueryOperation *operation) {
            block(operation.responseResults);
            return nil;
        }];
    }
    [operation start];
}

- (ODEntity *)objectAtIndexedSubscript:(NSUInteger)index {
    ODRetrievalByIndex *retrieval = [ODRetrievalByIndex new];
    retrieval.parent = self.retrievalInfo;
    retrieval.index = index;

    return [self.entityType entityWithInfo:retrieval];
}

- (void)retrieveCount {
    [self.readManager retrieveCount:self];
}

@end
