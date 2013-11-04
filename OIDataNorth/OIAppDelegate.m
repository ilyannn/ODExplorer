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
#import "ODCollection.h"

#import "ODResourceViewControllerMenu.h"

@implementation OIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
    ODResourceList *root = [[ODResourceList alloc] initFromDefaults];
//    [root retrieveMetadata];
    
    ODResourceViewControllerMenu *sharedMenu = [ODResourceViewControllerMenu sharedMenu];
    sharedMenu.favorites = root;

    UINavigationController *nc = (UINavigationController *)self.window.rootViewController;
    [nc pushViewController:[ODResourceViewController controllerForResource:root] animated:YES];

    NSURL *URL = launchOptions[UIApplicationLaunchOptionsURLKey];
    if (URL) {
        ODCollection *service = [ODCollection resourceWithURL:URL description:@"from parameters"];
        [root.childrenArray addObject:service];
        [nc pushViewController:[ODResourceViewController controllerForResource:service] animated:NO];
    }
    
//    NSURL *localURL = [NSURL fileURLWithPath:@"~/Library/favorites.json"];
    return YES;
}

- (void)loadArticles
{/*
    RKObjectMapping* articleMapping = [RKObjectMapping mappingForClass:[Article class]];
    [articleMapping addAttributeMappingsFromDictionary:@{
                                                         @"title": @"title",
                                                         @"body": @"body",
                                                         @"author": @"author",
                                                         @"publication_date": @"publicationDate"
                                                         }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping pathPattern:nil keyPath:@"articles" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:@"http://restkit.org/articles"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load collection of Articles: %@", mappingResult.array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    [objectRequestOperation start];
*/
    
}

- (void)loadArticles_OD {
    // Instantiating ODCollection ensures that that operation will fail if server tries to return something else.
    ODCollection *articles = [ODCollection resourceWithURL:[NSURL URLWithString:@"http://restkit.org/articles"]
                              // Description is useful for debugging or displaying the resource to user.
                                               description:@"My article list"];
//    articles.entityType = [Article entityType];
    //    [articles.readManager addCompletionHandler:]
    [articles retrieve];
    
    // start using articles.childrenArray; it will be updated in the background as necessary
}

- (id)loadArticles_minimal {
//    [ODResource sharedReadManager].autoretrieve = YES;
    return [[ODCollection resourceWithURLString:@"http://restkit.org/articles"] autoretrieve].childrenArray;
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
