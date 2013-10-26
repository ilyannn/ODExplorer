//
//  ODServiceList.h
//  OIDataNorth
//
//  Created by ilya on 10/25/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"

@interface ODResourceList : ODResource
- (instancetype)initFromDefaults;

@property NSMutableArray *childResources;
- (void)saveToDefaults;
- (void)loadFromDefaults;

@end
