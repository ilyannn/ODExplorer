//
//  OIODResourceViewControllerMenu.m
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODExplorerViewActionsMenu.h"

#import <UIKit/UIKit.h>

#import "ODResourceList.h"
#import "ODCreateOperation.h"

@interface ODExplorerViewActionsMenu ()

/// This consists of blocks to be executed.
@property NSMutableArray *actions;

@end

@interface ODExplorerViewActionsMenu(ActionSheetDelegate) <UIActionSheetDelegate>

@end

@interface ODExplorerViewActionsMenu(AlertViewDelegate) <UIAlertViewDelegate>

@end


@implementation ODExplorerViewActionsMenu {
    UIActionSheet *_actionSheet;
}

- (void)setResource:(ODResource *)resource {
    if (resource != _resource) {
        _resource = resource;
        _actionSheet = nil;
    }
}

- (void)buildButton:(NSString *)title withAction:(dispatch_block_t)block {
    [self.actionSheet addButtonWithTitle: [[NSBundle mainBundle] localizedStringForKey:title value:@"" table:nil]];
    [self.actions addObject:block];
}

- (UIActionSheet *)actionSheet {
    if (!_actionSheet) {
        [self buildMenu];
    }
    return _actionSheet;
}

- (void)buildMenu {
    __weak ODExplorerViewActionsMenu *weakSelf = self;

    BOOL remove = [weakSelf.favorites.childrenArray containsObject:weakSelf.resource];
    
    _actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                     destructiveButtonTitle:remove ? NSLocalizedString(@"Remove from Favorites", @"Menu action") : nil
                                          otherButtonTitles:remove ? nil : NSLocalizedString(@"Add to Favorites", @"Menu Action")
                                                            , nil];

    _actions = [[NSMutableArray alloc] initWithObjects:(self.favorites != self.resource) ? ^{
        if (!remove) {
            [weakSelf.favorites addResourceToList: weakSelf.resource];
        } else {
            [weakSelf.favorites removeResourceFromList: weakSelf.resource];
        }
        weakSelf.resource = nil; // so that menu will be re-created next time.
    } : ^{ [weakSelf newURLInFavorites]; } , nil];
    
    NSString *URLString = [weakSelf.resource.URL absoluteString];
    if (URLString) {
        [self buildButton:NSLocalizedString(@"Copy Resource URL", @"Menu action") withAction:^{
            [UIPasteboard generalPasteboard].string = URLString;
        }];
    }
    
/*    switch (self.resource.kind) {
        case ODResourceKindCollection:
        {[self buildButton:@"Create New Entity" withAction:^{
            
        }];}
            break;
        
        case ODResourceKindEntity:
        {[self buildButton:@"Edit This Entity" withAction:^{
            
        }];}
            
            break;
            
        default:;
    }
*/
    
    [self.actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", @"Menu cancel action")];
    self.actionSheet.cancelButtonIndex = self.actionSheet.numberOfButtons - 1;
}

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

@end


@implementation ODExplorerViewActionsMenu (ActionSheetDelegate)

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        dispatch_block_t block = self.actions[buttonIndex];
        block();
    }
}

@end

@implementation ODExplorerViewActionsMenu (AlertViewDelegate)

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        ODResource *resource = [ODResource resourceWithURLString:[alertView textFieldAtIndex:0].text];
        [self.favorites addResourceToList:resource];
        self.resource = nil;
    }
}

@end
