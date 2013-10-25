//
//  ODResourceViewController.h
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODResource, ODResourceTableViewCell;

extern NSString * const ODGenericCellReuseID;

@interface ODResourceViewController : UITableViewController
+ (ODResourceViewController *)controllerForResource:(ODResource *)resourc;

@property (readwrite, nonatomic) ODResource *resource;
@property (readwrite, nonatomic) NSArray *childIdentifiers;

@property (getter = isSubscribed, nonatomic) BOOL subscribed;

- (NSDictionary *)cellClasses;
- (void)refreshChildren;
- (NSString *)cellReuseIDForChild:(id)childID;
- (void)configureCell:(ODResourceTableViewCell *)cell forChild:(id)childID;


// This method will be called when the view becomes visible to retrieve active data
// and continue retrieving them further.
- (void)subscribeToResource;
- (void)unsubscribeFromResource;

@end

@interface ODResourceViewController (ViewControllers)
+ (Class)viewControllerClassFor:(Class)resourceClass;
@end