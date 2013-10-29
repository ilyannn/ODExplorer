//
//  OIODResourceViewControllerMenu.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ODResource, ODResourceList;

@interface ODResourceViewControllerMenu : NSObject
+ (ODResourceViewControllerMenu *)sharedMenu;

@property UIActionSheet *actionSheet;
@property (nonatomic) ODResource *resource;
@property ODResourceList *favorites;

@end
