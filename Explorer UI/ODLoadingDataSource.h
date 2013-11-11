//
//  ODLoadingDataSource.h
//  OIDataNorth
//
//  Created by ilya on 11/9/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODBaseResourceDataSource.h"

@interface ODLoadingDataSource : ODBaseResourceDataSource

/// Used to display or hide "loading row".
@property (nonatomic, getter = isCurrentlyLoading) BOOL currentlyLoading;
- (BOOL)hasLoadingRow;
- (BOOL)isLoadingRowIndexPath:(NSIndexPath *)indexPath;

@end
