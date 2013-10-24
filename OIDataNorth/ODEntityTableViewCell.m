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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setHeadlineProperties:(NSMutableArray *)headlineProperties {
    if (headlineProperties != _headlineProperties) {
        _headlineProperties = headlineProperties;
        [self configure];
    }
}

- (void)configure {
    if (self.resource) {
        __block NSString *headline = nil;
        [self.headlineProperties enumerateObjectsUsingBlock: ^(NSString *key, NSUInteger idx, BOOL *stop) {
            id value = self.resource.localProperties[key];
            if (value) {
                headline = [value description];
                *stop = YES;
            }
        }];
        self.textLabel.text = headline ? headline : self.resource.URL.relativePath;
        self.detailTextLabel.text = [self.resource.retrievalInfo shortDescription];
    }
}

@end
