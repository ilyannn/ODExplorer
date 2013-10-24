//
//  ODResourceViewController.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceViewController.h"

@implementation ODResourceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.subscribed = YES;
    if (!self.refreshControl) {
        self.refreshControl = [UIRefreshControl new];
        [self.refreshControl addTarget:self action:@selector(refreshControlActivated) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)refreshControlActivated {
    [self refreshData];
    [self.refreshControl endRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.subscribed = NO;
    [super viewWillDisappear:animated];
}

- (void)setResource:(ODResource *)resource {
    if (resource != _resource) {
        BOOL wasSubscribed = self.subscribed;
        self.subscribed = NO;
        _resource = resource;
        // this should automatically start refresh as well
        self.subscribed = wasSubscribed;
    }
}

- (void)setSubscribed:(BOOL)subscribed {
    if (subscribed != _subscribed) {
        _subscribed = subscribed;
        if (subscribed) {
            [self subscribeToResource];
        } else {
            [self unsubscribeFromResource];
        }
    }
}
- (void)refreshData {
}

- (void)subscribeToResource {
}

- (void)unsubscribeFromResource {
}

@end
