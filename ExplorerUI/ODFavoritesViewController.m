//
//  ODFavoritesViewController.m
//  ODExplorerLib
//
//  Created by ilya on 11/11/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODFavoritesViewController.h"

#import "ODExplorerViewController.h"
#import "ODFavorites.h"

@interface ODFavoritesViewController ()
@property ODExplorerViewController *rootViewController;
@end

@implementation ODFavoritesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.rootViewController = [ODExplorerViewController controllerForResource:[self rootResourceList]];
        [self pushViewController:self.rootViewController animated:NO];
    }
    return self;
}

- (ODFavorites *)rootResourceList {
    return [ODFavorites sharedFavorites];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openURL:(NSURL *)url {
    if (url) {

        if (![url.scheme hasPrefix:@"http"]) {
            url = [[NSURL alloc] initWithScheme:@"http" host:[url host] path:[url path]];
        }
        
        [self.rootViewController pushResource:
            [ODResource resourceWithURL:url description:[url absoluteString]]
         ];
    }
}
@end
