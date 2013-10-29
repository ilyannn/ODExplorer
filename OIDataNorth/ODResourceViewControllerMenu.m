//
//  OIODResourceViewControllerMenu.m
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceViewControllerMenu.h"
#import "ODResourceList.h"

@interface ODResourceViewControllerMenu () <UIActionSheetDelegate, UIAlertViewDelegate>

/// This consists of blocks to be executed.
@property NSMutableArray *actions;

@end

@implementation ODResourceViewControllerMenu

+ (ODResourceViewControllerMenu *)sharedMenu {
    static ODResourceViewControllerMenu*_sharedMenu;
    if (!_sharedMenu) {
        _sharedMenu = [ODResourceViewControllerMenu new];
    }
    return _sharedMenu;
}

- (void)setResource:(ODResource *)resource {
    if (resource != _resource) {
        _resource = resource;
        [self buildMenuForResource:resource];
    }
}

- (void)buildMenuForResource:(ODResource *)resource {
    __weak ODResourceViewControllerMenu *weakSelf = self;

    BOOL remove = [weakSelf.favorites.childrenArray containsObject:weakSelf.resource];
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                     destructiveButtonTitle:remove ? @"Remove from favorites" : nil
                                          otherButtonTitles:remove ? nil : @"Add to favorites" , nil];

    self.actions = [[NSMutableArray alloc] initWithObjects:(weakSelf.favorites != weakSelf.resource) ? ^{
        if (!remove) {
            [weakSelf.favorites addResourceToList: weakSelf.resource];
        } else {
            [weakSelf.favorites removeResourceFromList: weakSelf.resource];
        }
        self.resource = nil; // so that menu will be re-created next time.
    } : ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"URL to add"
        message:nil delegate:weakSelf
        cancelButtonTitle:@"Cancel"
        otherButtonTitles:@"Add", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        alertView.delegate = weakSelf;
        [alertView textFieldAtIndex:0].text = @"http://";
        [alertView show];
    } , nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        dispatch_block_t block = self.actions[buttonIndex];
        block();
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        ODResource *resource = [ODResource resourceWithURLString:[alertView textFieldAtIndex:0].text];
        [self.favorites addResourceToList:resource];
        self.resource = nil;
    }
}

@end
