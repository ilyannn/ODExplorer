//
//  OIODResourceViewControllerMenu.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@import UIKit;
@class ODResource;

@interface ODExplorerActivities : NSObject
- (instancetype)initWithResource:(ODResource *)resource;
@property (readonly) ODResource *resource;

@property (readonly) NSURL *shareURL;
- (UIViewController *)controller;
@end
