//
//  ODServiceList.h
//  OIDataNorth
//
//  Created by ilya on 10/25/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"

@interface ODServiceList : ODResource
- (instancetype)initFromDefaults;

@property NSMutableArray *services;
- (void)saveToDefaults;
- (void)loadFromDefaults;

@end
