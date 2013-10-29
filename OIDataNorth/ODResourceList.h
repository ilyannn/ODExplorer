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

- (void)saveToDefaults;
- (void)loadFromDefaults;

- (void)addResourceToList:(ODResource *)resource;
- (void)removeResourceFromList:(ODResource *)resource;

@end
