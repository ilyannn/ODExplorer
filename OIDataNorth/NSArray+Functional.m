//
//  NSArray+Functional.m
//  OIDataNorth
//
//  Created by ilya on 10/31/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "NSArray+Functional.h"

@implementation NSArray (Functional)

- (NSArray *)arrayByMapping:(id (^)(id))func {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = func(obj);
        if (value) [result addObject:value];
    }];
    return [result copy];
}

- (NSArray *)arrayByFiltering:(BOOL (^)(id))func {
    return [self arrayByMapping:^id(id obj) {
        return func(obj) ? obj : nil;
    }];
}

- (id)objectByReducing:(id (^)(id, id))func {
    __block id result;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        result = !idx ? obj : func(result, obj);
    }];
    return result;
}

@end
