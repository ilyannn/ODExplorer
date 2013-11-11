//
//  ODLoadingDataSource.m
//  OIDataNorth
//
//  Created by ilya on 11/9/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODLoadingDataSource.h"
#import "ODLoadingTableViewCell.h"

NSString *const ODLoadingCellReuseID = @"LoadingCell";

@implementation ODLoadingDataSource

- (NSDictionary *)cellClasses {
    NSMutableDictionary *classes = [[super cellClasses] mutableCopy];
    classes[ODLoadingCellReuseID] = [ODLoadingTableViewCell class];
    return [classes copy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section] + [self hasLoadingRow];
}

- (BOOL)hasLoadingRow {
    return [self empty] && self.currentlyLoading;
}

- (BOOL)isLoadingRowIndexPath:(NSIndexPath *)indexPath {
    return [self hasLoadingRow] && (0 == indexPath.row);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isLoadingRowIndexPath:indexPath]) {
        return [tableView dequeueReusableCellWithIdentifier:ODLoadingCellReuseID forIndexPath:indexPath];
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


@end
