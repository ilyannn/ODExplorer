//
//  ODResourceViewController.h
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODResourceTableViewCell, ODBaseResourceDataSource;
@protocol ODResource;

/// This is a basic controller that displays resource data as a table. It doesn't do anything to load it, though.
/// All methods are overrideable.
@interface ODBaseResourceViewController : UITableViewController

@property (readwrite, nonatomic) id<ODResource> resource;

/// Used to create a controller for a given resource. By default it returns controller of
/// current class initialized with -initWthResourse, but you're free to override it to return controllers
/// of some different class. This method is also used when selecing a row in the current controller.
+ (instancetype)controllerForResource:(id<ODResource>)resource;

/// Method to configure view controller for resource.
- (void)configure;

@property (readonly) ODBaseResourceDataSource *resourceDataSource;
- (ODBaseResourceDataSource *)resourceDataSourceFactory;

/// To override if different logic for child view controllers is desired. Note that +controllerForResource
/// is a more natural place for changes that only include view controller's class.
- (void)pushResource:(id<ODResource>)resource;
@end


