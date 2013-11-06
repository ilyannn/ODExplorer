//
//  ODFavoritesViewController.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODFavoritesViewController.h"
#import "ODExplorerViewController.h"
#import "ODFavorites.h"

@interface ODFavoritesViewController ()
@property (nonatomic) ODFavorites *root;
@end

//    NSURL *localURL = [NSURL fileURLWithPath:@"~/Library/favorites.json"];

@implementation ODFavoritesViewController

- (ODFavorites *)root {
    if (!_root) {
        _root = [ODFavorites sharedFavorites];
    }
    return _root;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
    [self pushResource:self.root];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushResource:(id<ODResourceAccessing>)resource {
    [self pushViewController:[ODExplorerViewController controllerForResource:resource] animated:YES];
}

@end
