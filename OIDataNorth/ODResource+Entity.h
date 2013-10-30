//
//  ODResource+Entity.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntity.h"

@class CollectionProxy;

/// Internal information about properties and methods of ODResource availible only for entities.
@interface ODResource (Entity) <ODEntityAccessing>
- (NSArray *)childrenArrayForEntity;
- (NSError *)parseFromJSONDictionary:(NSDictionary *)dict;

@property (readonly) id dateTimeFormatterV2;
@property (readonly) id dateTimeFormatterV3;

@property (nonatomic) NSMutableDictionary *localProperties;

@end
