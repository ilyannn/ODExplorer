//
//  ODEntityType.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODNominalType.h"

@class ODEntity;

@interface ODStructuredType : ODNominalType

- (id)initWithName:(NSString *)name;

@property (readonly) NSString *entityClassName;
@property (readonly) NSString *collectionClassName;

- (ODEntity *)entityWithInfo:(id)info;

/// This attribute holds types.
@property (readonly) NSMutableDictionary *properties;

/// This attribute holds names of key properties.
@property (readonly) NSMutableArray *keyProperties;

@end
