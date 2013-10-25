//
//  ODServiceTableViewCell.h
//  OIDataNorth
//
//  Created by ilya on 10/25/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceTableViewCell.h"

#import "ODService.h"

@interface ODServiceTableViewCell : ODResourceTableViewCell
@property (nonatomic) ODService *resource;
@end
