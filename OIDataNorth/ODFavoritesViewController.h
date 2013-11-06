//
//  ODFavoritesViewController.h
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODFavorites;
@protocol ODResourceAccessing;

@interface ODFavoritesViewController : UINavigationController

- (void)pushResource:(id<ODResourceAccessing>)resource;

@end
