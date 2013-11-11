//
//  ODExplorerViewController+Notify.m
//  OIDataNorth
//
//  Created by ilya on 11/9/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODExplorerViewController+Notify.h"
#import "ODOperation.h"

@implementation ODExplorerViewController (Notify)

- (void)manager:(ODNotifyingManager *)manager willStart:(ODOperation *)operation {
    if (operation.retrievalInfo == self.resource.retrievalInfo) {
        self.currentlyLoading = YES;
    }
}

- (void)manager:(ODNotifyingManager *)manager didFinish:(ODOperation *)operation {
    if (operation.retrievalInfo == self.resource.retrievalInfo) {
        self.currentlyLoading = NO;
    }
    [self.tableView reloadData];
}

@end
