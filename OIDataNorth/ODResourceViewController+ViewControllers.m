//
//  ODResourceViewController+ViewControllers.m
//  OIDataNorth
//
//  Created by ilya on 10/25/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODServiceViewController.h"
#import "ODCollectionViewController.h"
#import "ODEntityViewController.h"
#import "ODServiceListViewController.h"

@implementation ODResourceViewController (ViewControllers)
+ (Class)viewControllerClassFor:(ODResource *)resource {
    switch (resource.kind) {
        case ODResourceKindEntity:
            return [ODEntityViewController class];
            
        case ODResourceKindCollection:
            if ([resource isKindOfClass:[ODService class]]) {
                return [ODServiceViewController class];
            }
            if ([resource isKindOfClass:[ODCollection class]]) {
                return [ODCollectionViewController class];
            }
            if ([resource isKindOfClass:[ODResourceList class]]) {
                return [ODServiceListViewController class];
            }
            
        default:
            return nil;
    }
}

@end
