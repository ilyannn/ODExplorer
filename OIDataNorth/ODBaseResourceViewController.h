//
//  ODResourceViewController.h
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODResourceTableViewCell;
@protocol ODResource;

/// All methods are overrideable.
@interface ODBaseResourceViewController : UITableViewController

@property (readwrite, nonatomic) id<ODResource> resource;

/// Used to create a controller for a given resource. By default it returns controller of
/// current class, but you're free to override it to return controllers of some different class.
+ (instancetype)controllerForResource:(id<ODResource>)resource;

/// Method to configure view controller for resource.
- (void)configure;

/// Method to configure cell for resource.
- (void)configureCell:(ODResourceTableViewCell *)cell;

/// To override if different child view controllers are necessary.
- (void)pushResource:(id<ODResource>)resource;
@end


