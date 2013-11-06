//
//  OIODResourceViewControllerMenu.m
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODExplorerViewActionsMenu.h"

#import "ODResourceList.h"
#import "ODCreateOperation.h"

@interface ODExplorerViewActionsMenu () <UIActionSheetDelegate, UIAlertViewDelegate>

/// This consists of blocks to be executed.
@property NSMutableArray *actions;

@end

@implementation ODExplorerViewActionsMenu

+ (ODExplorerViewActionsMenu *)sharedMenu {
    static ODExplorerViewActionsMenu*_sharedMenu;
    if (!_sharedMenu) {
        _sharedMenu = [ODExplorerViewActionsMenu new];
    }
    return _sharedMenu;
}

- (void)setResource:(ODResource *)resource {
    if (resource != _resource) {
        _resource = resource;
        [self buildMenu];
    }
}

- (void)buildButton:(NSString *)title withAction:(dispatch_block_t)block {
    [self.actionSheet addButtonWithTitle: [[NSBundle mainBundle] localizedStringForKey:title value:@"" table:nil]];
    [self.actions addObject:block];
}

- (void)buildMenu {
    __weak ODExplorerViewActionsMenu *weakSelf = self;

    BOOL remove = [weakSelf.favorites.childrenArray containsObject:weakSelf.resource];
    
    _actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                     destructiveButtonTitle:remove ? @"Remove from Favorites" : nil
                                          otherButtonTitles:remove ? nil : @"Add to Favorites" , nil];

    self.actions = [[NSMutableArray alloc] initWithObjects:(self.favorites != self.resource) ? ^{
        if (!remove) {
            [weakSelf.favorites addResourceToList: weakSelf.resource];
        } else {
            [weakSelf.favorites removeResourceFromList: weakSelf.resource];
        }
        weakSelf.resource = nil; // so that menu will be re-created next time.
    } : ^{ [weakSelf newURLInFavorites]; } , nil];
    
    NSString *URLString = [weakSelf.resource.URL absoluteString];
    if (URLString) {
        [self buildButton:@"Copy Resource URL" withAction:^{
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
    
    [self.actionSheet addButtonWithTitle:@"Cancel"];
    self.actionSheet.cancelButtonIndex = self.actionSheet.numberOfButtons - 1;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        dispatch_block_t block = self.actions[buttonIndex];
        block();
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        ODResource *resource = [ODResource resourceWithURLString:[alertView textFieldAtIndex:0].text];
        [self.favorites addResourceToList:resource];
        self.resource = nil;
    }
}

- (void)newURLInFavorites {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"URL to add"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Add",
                              nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].text = @"http://";
    [alertView show];
}

@end
