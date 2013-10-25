//
//  ODPropertyTableViewCell.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPropertyTableViewCell.h"

@implementation ODPropertyTableViewCell


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
        self.detailTextLabel.text = [self.resource.localProperties[self.propertyName] description];
    }
}

@end
