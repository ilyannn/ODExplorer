//
//  ODEntityViewController.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntityViewController.h"
#import "ODPropertyTableViewCell.h"

NSString *const ODPropertyCellReuseID = @"PropertyCell";

@implementation ODEntityViewController {
    NSArray *listedProperties;
}

- (Class)propertyCellClass {
    return [ODPropertyTableViewCell class];
}

- (void)loadView {
    [super loadView];
    [self.tableView registerClass:[self propertyCellClass]
           forCellReuseIdentifier:ODPropertyCellReuseID];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadProperties];
}

- (void)reloadProperties {
    listedProperties = [[self.resource localProperties] allKeys];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listedProperties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ODPropertyTableViewCell *cell = [tableView
                                     dequeueReusableCellWithIdentifier:ODPropertyCellReuseID
                                     forIndexPath:indexPath
                                     ];
    cell.propertyName = listedProperties[indexPath.row];
    cell.resource = self.resource;
    return cell;
}

@end
