//
//  ODResourceDataSource.h
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODResource.h"

extern NSString *const ODGenericCellReuseID;
extern NSString *const ODLoadingCellReuseID;
extern NSString *const ODPrimitiveCellReuseID;
extern NSString *const ODBracketedCellReuseID;

@interface ODResourceDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithResource:(id<ODResource>)resource;
@property (readonly) id<ODResource> resource;

- (NSDictionary *)cellClasses;
- (NSString *)cellIDForResource:(ODResource *)child;

@end
