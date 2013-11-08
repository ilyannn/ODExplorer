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

@interface ODBaseResourceViewController : UITableViewController

#pragma mark - Instantiation

+ (UIViewController *)controllerForResource:(id<ODResource>)resource;
@property (readwrite, nonatomic) id<ODResource> resource;

#pragma mark - Configuration

/// Method to configure view controller for resource.
- (void)configure;

/// Method to configure cell for resource.
- (void)configureCell:(ODResourceTableViewCell *)cell;
@end


