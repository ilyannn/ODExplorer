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

- (NSDictionary *)cellClasses {
    return @{ODGenericCellReuseID : [ODPropertyTableViewCell class]};
}

- (void)refreshChildren {
    self.childIdentifiers = [[self.resource localProperties] allKeys];
}

- (void)configureCell:(ODPropertyTableViewCell *)cell forChild:(id)childID {
    cell.propertyName = childID;
    cell.resource = self.resource;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // do nothing
}

@end
