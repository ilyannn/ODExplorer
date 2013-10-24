//
//  ODRetrieveCollection.m
//  ODNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODQueryOperation.h"
#import "ODCollection.h"
#import "ODEntityType.h"

NSString* const ODQuerySelectString  = @"$select";
NSString* const ODQueryFilterString  = @"$filter";
NSString* const ODQueryTopString     = @"$top";
NSString* const ODQuerySkipString    = @"$skip";
NSString* const ODQueryExpandString  = @"$expand";
NSString* const ODQueryOrderByString = @"$orderby";


@implementation ODQueryOperation

+ (instancetype)operationWithResource:(ODCollection *)collection {
    return [super operationWithResource:collection];
}

- (NSString *)filter {
    return self.parameters[ODQueryFilterString];
}

- (NSString *)orderBy {
    return self.parameters[ODQueryOrderByString];
}

- (NSString *)select {
    return self.parameters[ODQuerySelectString];
}

- (NSString *)expand {
    return self.parameters[ODQueryExpandString];
}

- (NSUInteger)top {
    return [self.parameters[ODQueryTopString] integerValue];
}

- (NSUInteger)skip {
    return [self.parameters[ODQuerySkipString] integerValue];
}

- (void)setSelect:(id)select {
    self.parameters[ODQuerySelectString] = [select description];
}

- (void)setFilter:(id)filter {
    self.parameters[ODQueryFilterString] = [filter description];
}

- (void)setOrderBy:(id)orderBy {
    self.parameters[ODQueryOrderByString] = [orderBy description];
}

- (void)setExpand:(id)expandObject {
    self.parameters[ODQueryExpandString] = [expandObject description];
}

- (void)setTop:(NSUInteger)top {
    if (top) {
        self.parameters[ODQueryTopString] = [NSString stringWithFormat:@"%lu", (unsigned long)top];
    } else {
        [self.parameters removeObjectForKey:ODQueryTopString];
    }
}

- (void)setSkip:(NSUInteger)skip {
    if (skip) {
        self.parameters[ODQuerySkipString] = [NSString stringWithFormat:@"%lu", (unsigned long)skip];
    } else {
        [self.parameters removeObjectForKey:ODQuerySkipString];
    }
}

- (void)processJSONResponse:(id)response {
    NSArray *values = response[@"value"];
    
    if (!values) return;
    if (![values isKindOfClass:NSArray.class]) return;
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:values.count];
    [values enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger index, BOOL *stop) {
        if ([dict isKindOfClass:NSDictionary.class]) {
            ODEntity *entity = [[self.resource entityType] deserializeEntityFrom:dict];
            entity.parent = self.resource;
            [list addObject:entity];

            ODEntityRetrievalByIndex *retrieval = [ODEntityRetrievalByIndex new];
            retrieval.collection = (ODCollection *)self.resource;
            retrieval.index = self.skip + index;
            entity.retrievalInfo = retrieval;
        }
    }];
    _responseResults = [list copy];
}

@end
