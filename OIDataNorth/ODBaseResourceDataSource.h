//
//  ODResourceDataSource.h
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ODResource;

@interface ODBaseResourceDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithResource:(id<ODResource>)resource;
@property (readonly) id<ODResource> resource;
- (BOOL)empty;

#pragma mark - Configuration

- (NSDictionary *)cellClasses;
- (NSString *)cellIDForResource:(id<ODResource>)child;

/// Method to configure cell for resource. The default implementation is non-trivial only for collections,
/// where it tries to find out which properties of collection elements should be displayed in the cells.
- (void)configureCell:(id)cell;

@end
