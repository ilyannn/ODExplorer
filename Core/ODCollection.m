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

#import "ODResource+Collection.h"
#import "ODResource_Internal.h"
#import "ODRetrieving_Objects.h"

#import "ODStructuredType.h"
#import "ODPrimitiveType.h"

@implementation ODCollection 

// This is a designated initializer.
- (id)init {
    self = [super init];
    if (self) {
        self.kind = ODResourceKindCollection;
    }
    return self;
}

+ (instancetype)collectionForProperty:(NSString *)propertyName entityType:(ODPrimitiveType *)entityType inEntity:(ODEntity *)entity {
    ODCollection *collection = [[self alloc] initWithName:propertyName inParent:entity];
    collection.type = entityType;
    return collection;
}

- (instancetype)initWithName:(NSString *)name inParent:(ODResource *)parent {
    self = [self init];
    if (self) {
        
    }
    return self;
}

/*- (ODEntity *)objectAtIndexedSubscript:(NSUInteger)index {
    ODRetrievalByIndex *retrieval = [ODRetrievalByIndex new];
    retrieval.parent = self.retrievalInfo;
    retrieval.index = index;

    if ([self.type respondsToSelector:@selector(entityWithInfo:)])
        return [(ODStructuredType *)self.type entityWithInfo:retrieval];
    return nil;
}
*/

- (void)retrieveCount { 
    ODCountOperation *operation = [ODCountOperation operationWithResource: self];
    [operation addLastOperationStep:^NSError *(ODCountOperation *operation) {
        self.resourceValue = @(operation.responseCount);
        return nil;
    }];

    [self handleOperation:operation];
}

@end
