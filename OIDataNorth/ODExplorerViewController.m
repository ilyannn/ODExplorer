//
//  ODAutoLoadingViewController.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODExplorerViewActionsMenu.h"

#import "ODExplorerViewController.h"
#import "ODNotifyingManager.h"
#import "ODOperation.h"
#import "ODResource.h"
#import "ODFavorites.h"
#import "ODRetrieving_Objects.h"
#import "ODResourceDataSource.h"

@interface ODExplorerViewController (Notify) <ODNotifyingManagerDelegate>

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
    [(ODRetrieveBase *)[(ODResource *)self.resource retrievalInfo]
     addManager:[[ODNotifyingManager alloc] initWithDelegate:self ]];
}


- (void)displayActionMenu {
    ODExplorerViewActionsMenu *actionMenu = [ODExplorerViewActionsMenu new];
    actionMenu.resource = self.resource;
    actionMenu.favorites = [ODFavorites sharedFavorites];
    [actionMenu.actionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

- (void)setLoadingRowPresent:(BOOL)loadingRowPresent {
    if (_loadingRowPresent != loadingRowPresent) {
        _loadingRowPresent = loadingRowPresent;
        
        NSUInteger before = [self.tableView numberOfRowsInSection:0];
        NSUInteger after = [[self.resource childrenArray] count];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        
        if (before == 0 && after == 1) {
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        } else if (before == 1 && after == 0) {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [self.tableView reloadData];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return !self.loadingRowPresent || indexPath.row;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = [super tableView:tableView numberOfRowsInSection:section];
    return count + (!count) * self.loadingRowPresent;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.loadingRowPresent || indexPath.row) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    id cell = [tableView dequeueReusableCellWithIdentifier:ODLoadingCellReuseID forIndexPath:indexPath];
    return cell;
}

@end


@implementation ODExplorerViewController (Notify)

- (void)manager:(ODNotifyingManager *)manager willStart:(ODOperation *)operation {
    if (operation.retrievalInfo == self.resource.retrievalInfo && !self.loadingRowPresent) {
        self.loadingRowPresent = YES;
    }
}

- (void)manager:(ODNotifyingManager *)manager didFinish:(ODOperation *)operation {
    if (operation.retrievalInfo == self.resource.retrievalInfo && self.loadingRowPresent) {
        self.loadingRowPresent = NO;
    }
    [self.tableView reloadData];
}

@end
