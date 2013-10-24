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
    return [self valueForKey:ODQueryFilterString];
}

- (NSString *)orderBy {
    return [self valueForKey:ODQueryOrderByString];
}

- (NSString *)select {
    return [self valueForKey:ODQuerySelectString];
}

- (NSString *)expand {
    return [self valueForKey:ODQueryExpandString];
}

- (NSUInteger)top {
    return [[self valueForKey:ODQueryTopString] integerValue];
}

- (NSUInteger)skip {
    return [[self valueForKey:ODQuerySkipString] integerValue];
}

- (void)setSelect:(id)select {
    [self setValue:[select description] forKey:ODQuerySelectString];
}

- (void)setFilter:(id)filter {
    [self setValue:[filter description] forKey:ODQueryFilterString];
}

- (void)setOrderBy:(id)orderBy {
    [self setValue:[orderBy description] forKey:ODQueryOrderByString];
}

- (void)setExpand:(id)expandObject {
    [self setValue:[expandObject description] forKey:ODQueryExpandString];
}

- (void)setTop:(NSUInteger)top {
    NSString * value = !top ? nil : [NSString stringWithFormat:@"%lu", (unsigned long)top];
    [self setValue:value forKey:ODQueryTopString];
}

- (void)setSkip:(NSUInteger)skip {
    NSString * value = !skip ? nil : [NSString stringWithFormat:@"%lu", (unsigned long)skip];
    [self setValue:value forKey:ODQuerySkipString];
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
            retrieval.index = self.skip + index + 1;
            entity.retrievalInfo = retrieval;
        }
    }];
    _responseResults = [list copy];
}

@end
