//
//  ODEntityType.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODNominalType.h"

@class ODMutableStructuredType;

@interface ODStructuredType : ODNominalType <NSCopying, NSMutableCopying>

- (instancetype)initWithName:(NSString *)name properties:(NSDictionary *)properties keys:(NSArray *)keys;

/// This attribute holds types.
@property (readonly) NSDictionary *properties;

/// This attribute holds names of key properties.
@property (readonly) NSArray *keyProperties;

// - (ODStructuredType *)copy;
// - (ODMutableStructuredType *)mutableCopy;
@end
