//
//  ODResourceViewController.h
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ODResource, ODResourceTableViewCell, ODResourceViewControllerMenu;

extern NSString *const ODGenericCellReuseID;
extern NSString *const ODLoadingCellReuseID;
extern NSString *const ODPrimitiveCellReuseID;
extern NSString *const ODBracketedCellReuseID;

@interface ODResourceViewController : UITableViewController
+ (ODResourceViewController *)controllerForResource:(ODResource *)resourc;

@property (readwrite, nonatomic) ODResource *resource;
//@property (readwrite, nonatomic) NSArray *childIdentifiers;

@property (weak) UIBarButtonItem *actionButton;

- (NSDictionary *)cellClasses;
- (NSString *)cellIDForResource:(id)childID;
- (void)configureCell:(ODResourceTableViewCell *)cell forChild:(id)childID;


// Those are used only for collection view controllers.
@property (nonatomic) NSMutableArray *headlineProperties;

@end

@interface ODResourceViewController (ViewControllers)
+ (Class)viewControllerClassFor:(ODResource *)resource;
@end

#import "ODNotifyingManager.h"

@interface ODResourceViewController () <ODNotifyingManagerDelegate>
@property (nonatomic) BOOL loadingRowPresent;
@property NSInteger loadingRowIndex;
@end

