//
//  ODLoadingTableViewCell.m
//  OIDataNorth
//
//  Created by ilya on 10/27/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODLoadingTableViewCell.h"

@interface ODLoadingTableViewCell ()
@property UIActivityIndicatorView *activityIndicator;
@end

@implementation ODLoadingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = @"loading...";
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.accessoryView = self.activityIndicator;
        [self.activityIndicator startAnimating];
    }
    return self;
}


@end
