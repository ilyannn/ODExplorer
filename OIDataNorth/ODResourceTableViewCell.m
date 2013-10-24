//
//  ODResourceTableViewCell.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceTableViewCell.h"

@implementation ODResourceTableViewCell

- (void)setResource:(ODResource *)resource {
    if (_resource != resource) {
        _resource = resource;
        [self configure];
    }
}

- (void)configure {
}

@end
