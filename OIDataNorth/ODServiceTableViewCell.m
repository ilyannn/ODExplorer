//
//  ODServiceTableViewCell.m
//  OIDataNorth
//
//  Created by ilya on 10/25/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODServiceTableViewCell.h"

@implementation ODServiceTableViewCell

- (UITableViewCellStyle)cellStyle {
    return UITableViewCellStyleSubtitle;
}

- (void)configure {
    [super configure];
    self.detailTextLabel.text = [[self.resource URL] absoluteString];
}

@end
