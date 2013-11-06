//
//  ODResourceTableViewCell.h
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODResource;

@interface ODResourceTableViewCell : UITableViewCell
@property (nonatomic) ODResource *resource;
- (UITableViewCellStyle)cellStyle;
- (void)configure;

@end
