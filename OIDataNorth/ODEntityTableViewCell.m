//
//  ODEntityTableViewCell.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntityTableViewCell.h"
#import "Product.h"

@implementation ODEntityTableViewCell

- (UITableViewCellStyle)cellStyle {
    return UITableViewCellStyleValue1;
}

- (void)setHeadlineProperties:(NSMutableArray *)headlineProperties {
    if (headlineProperties != _headlineProperties) {
        _headlineProperties = headlineProperties;
        [self configure];
    }
}

- (void)configure {
    if (self.resource) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        __block NSString *headline = nil;
        [self.headlineProperties enumerateObjectsUsingBlock: ^(NSString *key, NSUInteger idx, BOOL *stop) {
            id value = self.resource.localProperties[key];
            if (value) {
                headline = [value description];
                *stop = YES;
            }
        }];
        
        self.textLabel.text = headline ? headline : @"(no readable description)";
        self.textLabel.alpha = (!!headline + 1.0) / 2.0;
        self.detailTextLabel.text = [self.resource.retrievalInfo shortDescription];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

@end
