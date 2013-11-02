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
@property (nonatomic) ODResource* resource;

@property (readonly) NSDateFormatter *dateTimeFormatter;
@property (readonly) NSDateFormatter *dateOnlyFormatter;

/// This will try to return it as a date only, if time is 0:0:0 in GMT representation.
- (NSString *)stringFromDate:(NSDate *)date;

@end
