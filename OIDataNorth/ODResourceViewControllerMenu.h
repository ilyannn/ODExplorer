//
//  OIODResourceViewControllerMenu.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ODResource, ODResourceList;

/// Menu of possible actions for a resource.
@interface ODResourceViewControllerMenu : NSObject

/// A singleton, to set favorites.
+ (ODResourceViewControllerMenu *)sharedMenu;

/// Menu can be different depending on resource
@property (nonatomic) ODResource *resource;

/// Use this property as a menu.
@property UIActionSheet *actionSheet;

/// Collection to use when "Add favorites" is selected.
@property ODResourceList *favorites;

@end
