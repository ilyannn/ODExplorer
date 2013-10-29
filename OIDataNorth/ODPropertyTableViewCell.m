//
//  ODPropertyTableViewCell.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPropertyTableViewCell.h"

@implementation ODPropertyTableViewCell

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *shared;
    if (!shared) {
        shared = [NSDateFormatter new];
        shared.dateStyle = NSDateFormatterMediumStyle;
        shared.timeStyle = NSDateFormatterMediumStyle;
    }
    return shared;
}

- (UITableViewCellStyle)cellStyle {
    return UITableViewCellStyleValue2;
}

- (void)setPropertyName:(NSString *)propertyName {
    if (![propertyName isEqualToString:_propertyName]) { // always true for nil
        _propertyName = propertyName;
        [self configure];
    }
}

- (void)configure {
    if (self.resource && self.propertyName) {
        self.textLabel.text = self.propertyName;
        id value = self.resource.localProperties[self.propertyName];
        NSString *formatted;
        UIColor *color;
        
        if ([value isKindOfClass:[NSDate class]]) {
            formatted = [self.dateFormatter stringFromDate:value];
            color = [UIColor brownColor];
        } else if ([value isKindOfClass:[NSData class]]) {
            formatted = [NSString stringWithFormat:@"data (%lu bytes)", (unsigned long)[value length]];
            color = [UIColor darkGrayColor];
        } else if ([value isKindOfClass:[NSURL class]]) {
            formatted = [value absoluteString];
            color = [UIColor blueColor];
        } else {
            formatted = [value description];
            color = [UIColor blackColor];
        }
        
        self.detailTextLabel.text = formatted;
        self.detailTextLabel.textColor = color;
    }
}

@end
