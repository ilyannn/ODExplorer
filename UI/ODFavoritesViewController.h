//
//  ODFavoritesViewController.h
//  ODExplorerLib
//
//  Created by ilya on 11/11/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ODResourceList;

@interface ODFavoritesViewController : UINavigationController

- (ODResourceList *)rootResourceList;
- (void)openURL:(NSURL *)url;

@end
