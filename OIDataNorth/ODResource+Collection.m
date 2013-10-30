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

#import "CollectionProxy.h"
#import "ODRetrievalInfo.h"

#import "ODCountOperation.h"
#import "ODQueryOperation.h"

#import "ODEntity.h"

#import "ODOperationError+Parsing.h"

#define ODCollectionAssert NSAssert(self.kind == ODResourceKindCollection, \
@"This should be called only for collections!");

@implementation ODResource (Collection)

- (CollectionProxy *)childrenArrayForCollection { ODCollectionAssert
    
    CollectionProxy *cache = [CollectionProxy new];
    cache.delegate = self;
    return cache;
}

- (NSError *)updateFromJSONArray:(NSArray *)array { ODCollectionAssert
    self.resourceValue = @([array count]);
    self.childrenArray = [array copy];
    return nil;
}

- (void)cleanCollectionOperation { ODCollectionAssert
    [self.childrenArray clean];
}

- (NSUInteger)batchSize {
    return 20;
}

- (void)countCollection {
    [self handleOperation:[self countCollectionOperation]];
}

- (ODCountOperation *)countOperation { ODCollectionAssert
    ODCountOperation *operation = [ODCountOperation operationWithResource:self];
    [operation addOperationStep:^NSError *(ODCountOperation *op) {
        self.resourceValue = @(op.responseCount);
        return nil;
    }];
    return operation;
}

- (void)cache:(CollectionProxy *)cache missingObjectAtIndex:(NSUInteger)index { ODCollectionAssert
    ODQueryOperation *operation = [ODQueryOperation operationWithResource:self];
    operation.top = [self batchSize];
    operation.skip = index;
    [operation addOperationStep:^NSError *(ODQueryOperation *op) {
        [op.responseResults enumerateObjectsUsingBlock: ^(ODEntity *obj, NSUInteger resultIndex, BOOL *stop) {
            cache[op.skip + resultIndex] = obj;
        }];
        return nil;
    }];

    [operation start];
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
                
                ODRetrievalOfEntitySet*info = [ODRetrievalOfEntitySet new];
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



@end
