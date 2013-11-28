//
//  ODFavoritesActivity.m
//  ODExplorerLib
//
//  Created by ilya on 11/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODFavoriteActivity.h"
#import "ODFavorites.h"

@interface ODFavoriteActivity (NewFavorite) <UIAlertViewDelegate>
- (void)newURLInFavorites;
@end

@implementation ODFavoriteActivity

#pragma mark - Configuration

- (instancetype)initWithResource:(ODResource *)resource {
    if (self = [super init]) {
        _resource = resource;
        [self configure];
    }
    return self;
}

- (ODResourceList *)favorites {
    return [ODFavorites sharedFavorites];
}

- (void)configure {
    if (self.favorites == self.resource) {
        _type = ODFavoriteActivityTypeManually;
    } else if ([self.favorites.childrenArray containsObject:self.resource]) {
        _type = ODFavoriteActivityTypeRemove;
    } else {
        _type = ODFavoriteActivityTypeAdd;
    }
}


#pragma mark - UIActivity

- (NSString *)activityType {
    return [NSString stringWithFormat:@"com.ilya.ODExplorer.%@", NSStringFromClass([self class])];
}


- (NSString *)activityTitle {
    return NSLocalizedString((@[@"Add to Favorites", @"Remove from Favorites", @"New Favorite"][self.type]),
                             @"Names for 'Add/Remove/New Favorite' activity in the activity view controller");
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"star"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return !!self.resource;
}

- (void)performActivity {
    switch (self.type) {
        case ODFavoriteActivityTypeAdd:
            [self.favorites addResourceToList: self.resource];
            [self activityDidFinish:YES];
            break;
            
        case ODFavoriteActivityTypeRemove:
            [self.favorites removeResourceFromList: self.resource];
            [self activityDidFinish:YES];
            break;

        case ODFavoriteActivityTypeManually:
            [self newURLInFavorites];
            break;
    }
}

@end

#pragma mark - Adding new URL in Favorites

@implementation ODFavoriteActivity (NewFavorite)

- (void)newURLInFavorites {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"URL to add", @"Alert view title")
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"Alert view button")
                                              otherButtonTitles:NSLocalizedString(@"Add", @"Alert view button"),
                              nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].text = @"http://";
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        ODResource *resource = [ODResource resourceWithURLString:[alertView textFieldAtIndex:0].text];
        [self.favorites addResourceToList:resource];
    }
    [self activityDidFinish:YES];
}

@end
