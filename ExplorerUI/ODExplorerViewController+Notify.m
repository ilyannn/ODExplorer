//
//  ODExplorerViewController+Notify.m
//  OIDataNorth
//
//  Created by ilya on 11/9/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODExplorerViewController+Notify.h"
#import "ODOperation.h"

#import "ODBaseRequestManager.h"

@implementation ODExplorerViewController (Notify)

- (void)handleOperation:(ODOperation *)operation {

    [operation addFirstOperationStep:^NSError *(id op) {
        [self performSelectorOnMainThread:@selector(setCurrentlyLoading:) withObject:@(YES) waitUntilDone:YES];
        return nil;
    }];
    
    [operation addCompletionBlock:^(id op) {
        [self performSelectorOnMainThread:@selector(setCurrentlyLoading:) withObject:@(NO) waitUntilDone:YES];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];

    [[ODBaseRequestManager new] handleOperation:operation];
}

@end
