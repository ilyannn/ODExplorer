//
//  ODEntityViewController.h
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODResourceViewController.h"
#import "ODEntity.h"

@interface ODEntityViewController : ODResourceViewController
@property (readwrite, nonatomic) ODEntity *resource;
- (void)reloadProperties;

- (Class)propertyCellClass;

@end
