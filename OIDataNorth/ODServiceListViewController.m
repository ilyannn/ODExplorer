//
//  ODServiceListViewController.m
//  OIDataNorth
//
//  Created by ilya on 10/25/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODServiceListViewController.h"

@implementation ODServiceListViewController

- (void)refreshChildren {
    [self.resource retrieve];
}

- (void)subscribeToResource {
    [self refreshChildren];
    [self.tableView reloadData];
}

@end
