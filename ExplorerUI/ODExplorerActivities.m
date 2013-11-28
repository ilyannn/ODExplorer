//
//  OIODResourceViewControllerMenu.m
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODExplorerActivities.h"

#import "ODResourceList.h"
#import "ODFavoriteActivity.h"

@interface ODExplorerActivities ()
@end


@implementation ODExplorerActivities

- (instancetype)initWithResource:(ODResource *)resource {
    if (self = [super init]) {
        _resource = resource;
        [self configure];
    }
    return self;
}

- (void)configure {
    if (self.resource.URL) {
        NSURLComponents *components = [NSURLComponents componentsWithURL:self.resource.URL resolvingAgainstBaseURL:YES];
        components.scheme = @"odata";
        components.password = nil;
        _shareURL = [components URL];
    }
}

- (UIViewController *)controller {
    NSArray *activities = @[[[ODFavoriteActivity alloc] initWithResource:self.resource]];
    
    NSMutableArray *items = [NSMutableArray arrayWithObject:self.resource];
    if (self.shareURL) {
        [items addObject: self.shareURL];
    }
    
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                     applicationActivities:activities];
    vc.excludedActivityTypes = @[UIActivityTypeAddToReadingList];
    return vc;
}

@end



