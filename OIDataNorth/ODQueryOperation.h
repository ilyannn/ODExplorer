//
//  OIDataRetrieveCollection.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODJSONOperation.h"

@class ODCollection;

@interface ODQueryOperation : ODJSONOperation

- (NSString *)filter;
- (void)setFilter:(id)filterObject;

- (NSString *)select;
- (void)setSelect:(id)selectObject;

- (NSString *)orderBy;
- (void)setOrderBy:(id)orderByObject;

- (NSString *)expand;
- (void)setExpand:(id)expandObject;

@property (readwrite, nonatomic) NSUInteger top;
@property (readwrite, nonatomic) NSUInteger skip;

@property NSArray *responseResults;

@end
