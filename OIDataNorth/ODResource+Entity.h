//
//  ODResource+Entity.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntity.h"

@class LazyMutableArray;

/// Internal information about properties and methods of ODResource availible only for entities.
@interface ODResource (Entity) <ODEntityAccessing>
- (NSArray *)childrenArrayForEntity;
@property (nonatomic) NSMutableDictionary *localProperties;

@end
