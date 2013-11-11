//
//  ODAutoLoadingViewController.h
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODBasicViewController.h"

@interface ODExplorerViewController : ODBasicViewController

/// Action when pressed on a menu button.
- (void)displayActionMenu;

@property (nonatomic, getter = isCurrentlyLoading) BOOL currentlyLoading;

@end
