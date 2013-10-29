//
//  ODEntityViewController.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntityViewController.h"
#import "ODPropertyTableViewCell.h"

@implementation ODEntityViewController

- (void)refreshChildren {
    self.loadingRowIndex = NSNotFound;
    self.childIdentifiers = [[[self.resource localProperties] allKeys] sortedArrayUsingComparator:
                             ^NSComparisonResult(NSString *obj1, NSString * obj2) {
                                 return [obj1 localizedCaseInsensitiveCompare:obj2];
                             }];
}

- (void)configureCell:(ODPropertyTableViewCell *)cell forChild:(id)childID {
    cell.propertyName = childID;
    cell.resource = self.resource;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
