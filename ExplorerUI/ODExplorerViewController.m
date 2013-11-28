//
//  ODAutoLoadingViewController.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODExplorerViewController.h"
#import "ODExplorerViewController+Notify.h"

#import "ODExplorerActivities.h"
#import "ODFavorites.h"
#import "ODRetrieving_Objects.h"

#import "ODLoadingDataSource.h"

@interface ODExplorerViewController ()
@property (readonly) ODLoadingDataSource *resourceDataSource;
- (ODLoadingDataSource *)resourceDataSourceFactory;
@end

@implementation ODExplorerViewController {
    // Strongly hold action menu instance.
    ODExplorerActivities *actionMenu;
}

- (ODResource *)resource {
    return [super resource];
}

- (void)setResource:(id<ODResource>)resource {
    [super setResource:resource];
}

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
    self.resource.parentManager = self;
}

- (ODBaseResourceDataSource *)resourceDataSourceFactory {
    return [[ODLoadingDataSource alloc] initWithResource:self.resource];
}

- (void)displayActionMenu {
    // store strong reference!
    actionMenu = [[ODExplorerActivities alloc] initWithResource:self.resource];
    [self presentViewController:[actionMenu controller] animated:YES completion:nil];
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


