//
//  ODAutoLoadingViewController.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODExplorerViewController.h"
#import "ODExplorerViewController+Notify.h"

#import "ODExplorerViewActionsMenu.h"
#import "ODFavorites.h"
#import "ODRetrieving_Objects.h"

#import "ODLoadingDataSource.h"

@interface ODExplorerViewController ()
@property (readonly) ODLoadingDataSource *resourceDataSource;
- (ODLoadingDataSource *)resourceDataSourceFactory;
@end

@implementation ODExplorerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                            target:self
                                                                            action:@selector(displayActionMenu)];
    
    self.navigationItem.rightBarButtonItem = button;
}

- (void)configure {
    [super configure];
    self.resource.automaticallyRetrieve = YES;
    // TODO
    ODRetrieveBase *base = (ODRetrieveBase *)[(ODResource *)self.resource retrievalInfo];
    [base addManager:[[ODNotifyingManager alloc] initWithDelegate:self]];
}

- (ODBaseResourceDataSource *)resourceDataSourceFactory {
    return [[ODLoadingDataSource alloc] initWithResource:self.resource];
}

- (void)displayActionMenu {
    ODExplorerViewActionsMenu *actionMenu = [ODExplorerViewActionsMenu new];
    actionMenu.resource = self.resource;
    actionMenu.favorites = [ODFavorites sharedFavorites];
    [actionMenu.actionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

- (void)setCurrentlyLoading:(BOOL)currentlyLoading {
    if (currentlyLoading != self.resourceDataSource.currentlyLoading) {

        NSInteger delta = -[self.resourceDataSource tableView:self.tableView numberOfRowsInSection:0];
        self.resourceDataSource.currentlyLoading = currentlyLoading;
        delta += [self.resourceDataSource tableView:self.tableView numberOfRowsInSection:0];

        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        
        switch (delta) {
            case 1:
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
                break;
            case -1:
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
        }
    }
}

- (BOOL)isCurrentlyLoading {
    return [self.resourceDataSource isCurrentlyLoading];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return ![self.resourceDataSource isLoadingRowIndexPath:indexPath];
}


@end


