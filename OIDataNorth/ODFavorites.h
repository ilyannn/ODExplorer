//
//  ODFavorites.h
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceList.h"

@interface ODFavorites : ODResourceList

+ (instancetype)sharedFavorites;
- (instancetype)initFromDefaults;

- (void)saveToDefaults;
- (void)loadFromDefaults;

@end
