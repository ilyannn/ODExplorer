//
//  Created by ilya on 10/31/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

/// Functional enhancements for an array class.
@interface NSArray (ODHFunctional)

- (NSArray *)arrayByMapping: (id(^)(id))func;
- (NSArray *)arrayByFiltering: (BOOL(^)(id))func;
- (id)objectByReducing: (id(^)(id, id))func;

@end
