//
//  ODResourceViewController.h
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODResource.h"

@interface ODResourceViewController : UITableViewController
@property (readwrite, nonatomic) ODResource *resource;
@property (getter = isSubscribed, nonatomic) BOOL subscribed;

- (void)refreshData;

// This method will be called when the view becomes visible to retrieve active data
// and continue retrieving them further.
- (void)subscribeToResource;
- (void)unsubscribeFromResource;

@end
