//
//  OIODResourceViewControllerMenu.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class UIActionSheet;
@class ODResourceList;
@protocol ODResource;

/// Menu of possible actions for a resource.
@interface ODExplorerViewActionsMenu : NSObject

/// Menu can be different depending on resource
@property (nonatomic) id<ODResource> resource;

/// Use this property as a menu.
@property (readonly)UIActionSheet *actionSheet;

/// Collection to use when "Add favorites" is selected.
@property ODResourceList *favorites;

@end
