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
    NSUInteger count = [super tableView:tableView numberOfRowsInSection:section];
    return count + (!count) * self.currentlyLoading;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isLoadingRowIndexPath:indexPath]) {
        return [tableView dequeueReusableCellWithIdentifier:ODLoadingCellReuseID forIndexPath:indexPath];
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (BOOL)isLoadingRowIndexPath:(NSIndexPath *)indexPath {
    return self.currentlyLoading && 0 == indexPath.row;
}

@end
