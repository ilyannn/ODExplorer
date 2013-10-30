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
}

- (void)configureCell:(ODPropertyTableViewCell *)cell forChild:(id)childID {
    cell.propertyName = childID;
    cell.resource = self.resource;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
