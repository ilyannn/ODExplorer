//
//  ODResourceTableViewCell.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceTableViewCell.h"

@implementation ODResourceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:[self cellStyle]  reuseIdentifier:reuseIdentifier];
}

- (UITableViewCellStyle)cellStyle {
    return UITableViewCellStyleSubtitle;
}

- (void)setResource:(ODResource *)resource {
    if (_resource != resource) {
        _resource = resource;
        [self configure];
    }
}

- (void)configure {
    self.textLabel.text = [self.resource shortDescription];
    self.detailTextLabel.text = self.resource.retrievalInfo.parent ? nil : [self.resource.URL absoluteString];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
