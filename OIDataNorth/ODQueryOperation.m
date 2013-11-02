//
//  ODRetrieveCollection.m
//  ODNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODQueryOperation.h"
#import "ODCollection.h"
#import "ODEntity.h"
#import "ODType.h"
#import "ODEntityRetrieval.h"

#import "ODOperationError+Parsing.h"

NSString *const ODQuerySelectString  = @"$select";
NSString *const ODQueryFilterString  = @"$filter";
NSString *const ODQueryTopString     = @"$top";
NSString *const ODQuerySkipString    = @"$skip";
NSString *const ODQueryExpandString  = @"$expand";
NSString *const ODQueryOrderByString = @"$orderby";


@implementation ODQueryOperation

+ (NSError *)errorForKind:(ODResourceKind)kind {
    ODAssertOperation(kind != ODResourceKindEntity, @"You can't query an entity.");
    return nil;
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
    NSString *value = !top ? nil : [NSString stringWithFormat:@"%lu", (unsigned long)top];
    [self setValue:value forKey:ODQueryTopString];
}

- (void)setSkip:(NSUInteger)skip {
    NSString *value = !skip ? nil : [NSString stringWithFormat:@"%lu", (unsigned long)skip];
    [self setValue:value forKey:ODQuerySkipString];
}

- (NSError *)processJSONResponseVerbose {
    NSArray *values = self.responseJSON[@"value"];
    
    if (!values && [self.responseJSON isKindOfClass:[NSDictionary class]] ) {
        values = [(NSDictionary *)self.responseJSON objectForKey: @"d"];
        if ([values isKindOfClass:[NSDictionary class]])
            values = [(NSDictionary *)values objectForKey:@"results"];
    }
    
    ODAssertOData(values, nil);
    ODAssertODataClass(values, NSArray);
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:values.count];
    [values enumerateObjectsUsingBlock: ^(NSDictionary *dict, NSUInteger index, BOOL *stop) {
        if ([dict isKindOfClass:NSDictionary.class]) {
            ODRetrievalByIndex *retrieval = [ODRetrievalByIndex new];
            retrieval.parent = self.retrievalInfo;
            retrieval.index = self.skip + index + 1;

            ODEntity *entity = [[ODEntity entityType] deserializeEntityFrom:dict withInfo:retrieval];
            [list addObject:entity];
        }
    }];
    
    _responseResults = [list copy];
    return nil;
}

@end
