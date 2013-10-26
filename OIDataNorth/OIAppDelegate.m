//
//  OIAppDelegate.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIAppDelegate.h"

#import "ODResourceViewController.h"
#import "ODBaseRequestManager.h"
#import "ODResourceList.h"
#import "ODService.h"

@implementation OIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
    ODResourceList *root = [[ODResourceList alloc] initFromDefaults];
    root.retrievalInfo.readManager = [ODBaseRequestManager nonblockingManager];
    root.retrievalInfo.changeManager = [ODBaseRequestManager nonblockingManager];
    
    UINavigationController *nc = (UINavigationController *)self.window.rootViewController;
    [nc pushViewController:[ODResourceViewController controllerForResource:root] animated:YES];

    NSURL *URL = launchOptions[UIApplicationLaunchOptionsURLKey];
    if (URL) {
        ODService *service = [ODService new];
        service.URL = URL;
        service.shortDescription = @"from parameters";
        [root.childResources addObject:service];
        [nc pushViewController:[ODResourceViewController controllerForResource:service] animated:NO];
    }
    
    
    
//    controller.headlineProperties = [@[@"ProductName", @"ProductID"] mutableCopy];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.

}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
