//
//  ODResource+Entity.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntity.h"

@class ODHLazyMutableArray;

/// Internal information about properties and methods of ODResource availible only for entities.
@interface ODResource (Entity) <ODEntity>
- (NSArray *)childrenArrayForEntity;
- (void)dropEntityChildrenRecursively:(BOOL)recursively;
@property (nonatomic) NSMutableDictionary *localProperties;

@end
