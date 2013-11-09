//
//  ODResource+Collection.m
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource+Collection.h"
#import "ODResource+Entity.h"
#import "ODResource_Internal.h"

#import "LazyMutableArray.h"
#import "ODRetrieving_Objects.h"

#import "ODCountOperation.h"
#import "ODQueryOperation.h"
#import "ODMetadataOperation.h"

#import "ODEntity.h"

#import "ODOperationError+Parsing.h"
#import "NSArray+Functional.h"

#define ODCollectionAssert NSAssert(self.kind == ODResourceKindCollection, \
@"This should be called only for collections!");

@implementation ODResource (Collection)

- (LazyMutableArray *)childrenArrayForCollection { ODCollectionAssert
    return [[LazyMutableArray alloc] initWithDelegate:self];
}

- (NSError *)updateFromJSONArray:(NSArray *)array { ODCollectionAssert
    self.resourceValue = @([array count]);
    self.childrenArray = [array copy];
    return nil;
}

- (NSUInteger)batchSize {
    return 25;
}

- (void)countCollection {
    [self handleOperation:[self countCollectionOperation]];
}

- (ODCountOperation *)countCollectionOperation { ODCollectionAssert
    ODCountOperation *operation = [ODCountOperation operationWithResource:self];
    [operation addOperationStep:^NSError *(ODCountOperation *op) {
        self.resourceValue = @(op.responseCount);
        if ([self.childrenArray count] != op.responseCount) {
            id array = self.childrenArray;
            if (![array respondsToSelector:@selector(setCount:)]) {
                // This is the only place children become CollectionCache.
                // In all other situations, NSArray is just fine.
                self.childrenArray = array = [[LazyMutableArray alloc] initWithDelegate:self contents:array];
            }
            [array setCount:op.responseCount];
        }
        return nil;
    }];
    return operation;
}

- (void)array:(LazyMutableArray *)lazy missingObjectAtIndex:(NSUInteger)index { ODCollectionAssert
    ODQueryOperation *operation = [ODQueryOperation operationWithResource:self];
    NSUInteger batchSize = [self batchSize];
    NSUInteger totalCount = [lazy count];
    operation.top = batchSize;
    operation.skip = index;
    
    for (NSUInteger batchIndex = 0; (batchIndex < batchSize) && (index + batchIndex < totalCount) ; batchIndex ++) {
        ODRetrievalByIndex *info = [ODRetrievalByIndex new];
        info.index = index + batchIndex;
        info.parent = self.retrievalInfo;
        lazy[index + batchIndex] = [[ODEntity alloc] initWithRetrievalInfo:info];
    }
    
    [operation addOperationStep:^NSError *(ODQueryOperation *op) {
        [op.responseResults enumerateObjectsUsingBlock: ^(ODEntity *obj, NSUInteger resultIndex, BOOL *stop) {
            lazy[index + resultIndex] = obj;
        }];
        return nil;
    }];

    [self handleOperation:operation];
}

- (NSError *)parseFromJSONArray:(NSArray *)array { ODCollectionAssert
    ODAssertODataClass(array, NSArray);
    
    NSMutableArray *result = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]] ) {
            NSString *url = obj[@"url"];
            NSString *name = obj[@"name"];
            if ([obj count] == 2
                && [url isKindOfClass:[NSString class]]
                && [name isKindOfClass:[NSString class]] ) {
                
                ODRetrievalOfEntitySet *info = [ODRetrievalOfEntitySet new];
                info.entitySetPath = url;
                info.shortDescription = name;
                info.parent = self.retrievalInfo;
                [result addObject:[ODCollection resourceWithInfo:info]];

            } else {
                
                ODRetrievalByIndex *info = [ODRetrievalByIndex new];
                info.parent = self.retrievalInfo;
                info.index = idx;
                ODEntity *entity = [ODEntity resourceWithInfo:info];
                NSError *error = [entity parseFromJSONDictionary:obj];
                if (!error) [result addObject:entity];
            }}}];
    self.childrenArray = [result copy];
    self.resourceValue = @([result count]);
    return nil;
}

- (NSError *)parseServiceDocumentFromArray:(NSArray *)array {
    ODAssertODataClass(array, NSArray);
    NSMutableArray *result = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(NSString *name, NSUInteger index, BOOL *stop){
        if ([name isKindOfClass:[NSString class]]) {
            ODRetrievalOfEntitySet *info = [ODRetrievalOfEntitySet new];
            info.entitySetPath = name;
            info.shortDescription = name;
            info.parent = self.retrievalInfo;
            [result addObject:[ODCollection resourceWithInfo:info]];
        }
    }];
    self.childrenArray = [result copy];
    self.resourceValue = @([result count]);
    return nil;
}

- (void)retrieveMetadata { ODCollectionAssert
    [self handleOperation:[self retrieveMetadataOperation]];
}

- (ODMetadataOperation *)retrieveMetadataOperation {
    
    ODMetadataOperation *operation = [ODMetadataOperation operationWithResource:self];
    [operation addOperationStep:^NSError *(ODMetadataOperation * op) {
        if (![self.retrievalInfo respondsToSelector:@selector(setMetadataModel:)]) {
            ODRouteMetadata *route = [ODRouteMetadata new];
            route.parent = self.retrievalInfo;
            self.retrievalInfo = route;
        }
        [(ODRouteMetadata *)self.retrievalInfo setMetadataModel:op.responseModel];
        return nil;
    }];
    
    return operation;
}

- (void)dropElementsOfCollectionRecursively:(BOOL)recursively { ODCollectionAssert
    id object = self.childrenArray;
    
    if (![object respondsToSelector:@selector(cleanWeakElements)]) {
        self.childrenArray = [LazyMutableArray arrayWithArray:object];
    }
    [object cleanWeakElements];

    if (recursively) {
        [object enumerateObjectsUsingBlock:^(id<ODResource> obj, NSUInteger idx, BOOL *stop) {
            [obj dropChildrenRecursively:YES];
        }];
    }
}

@end
