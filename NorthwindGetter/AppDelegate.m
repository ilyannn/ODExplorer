//
//  AppDelegate.m
//  NorthwindGetter
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "AppDelegate.h"

#import "NorthwindService.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NorthwindService *service = [NorthwindService new];
    NSArray *products = [service.Products list];
}

@end
