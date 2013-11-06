//
//  NSArray+Functional.h
//  OIDataNorth
//
//  Created by ilya on 10/31/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Functional enhancements for an array class.
@interface NSArray (Functional)

- (NSArray *)arrayByMapping: (id(^)(id))func;
- (NSArray *)arrayByFiltering: (BOOL(^)(id))func;
- (id)objectByReducing: (id(^)(id, id))func;

@end
