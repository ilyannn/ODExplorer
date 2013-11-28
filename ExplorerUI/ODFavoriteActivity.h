//
//  ODFavoritesActivity.h
//  ODExplorerLib
//
//  Created by ilya on 11/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@import UIKit;
@class ODResource;

enum ODFavoriteActivityType {
    ODFavoriteActivityTypeAdd = 0,
    ODFavoriteActivityTypeRemove = 1,
    ODFavoriteActivityTypeManually = 2,
};

@interface ODFavoriteActivity : UIActivity
- (instancetype)initWithResource:(ODResource *)resource;
@property (readonly) ODResource *resource;

@property (readonly) enum ODFavoriteActivityType type;
@end
