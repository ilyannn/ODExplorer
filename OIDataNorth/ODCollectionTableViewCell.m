//
//  ODCollectionTableViewCell.m
//  OIDataNorth
//
//  Created by ilya on 10/30/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollectionTableViewCell.h"

@implementation ODCollectionTableViewCell

- (void)configure {
    self.textLabel.text = [self.resource shortDescription];
    self.detailTextLabel.text = [self.resource.retrievalInfo isRootURL] ? [self.resource.retrievalInfo URL].absoluteString : nil;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
