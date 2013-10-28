//
//  ODPropertyTableViewCell.h
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceTableViewCell.h"
#import "ODEntity.h"

@interface ODPropertyTableViewCell : ODResourceTableViewCell
@property (nonatomic) ODEntity *resource;
@property (nonatomic) NSString *propertyName;

@property (readonly) NSDateFormatter *dateFormatter;
@end
