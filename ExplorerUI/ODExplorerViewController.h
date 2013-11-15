//
//  ODAutoLoadingViewController.h
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODResource;
#import "ODBaseResourceViewController.h"

@interface ODExplorerViewController : ODBaseResourceViewController

// TODO
- (ODResource *)resource;
- (void)setResource:(id<ODResource>)resource;

/// Action when pressed on a menu button.
- (void)displayActionMenu;

@property (nonatomic, getter = isCurrentlyLoading) BOOL currentlyLoading;

@end
