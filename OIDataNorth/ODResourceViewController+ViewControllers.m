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
+ (Class)viewControllerClassFor:(Class)resourceClass {
    if ([resourceClass isSubclassOfClass:[ODService class]]) {
        return [ODServiceViewController class];
    }
    if ([resourceClass isSubclassOfClass:[ODEntity class]]) {
        return [ODEntityViewController class];
    }
    if ([resourceClass isSubclassOfClass:[ODCollection class]]) {
        return [ODCollectionViewController class];
    }
    if ([resourceClass isSubclassOfClass:[ODServiceList class]]) {
        return [ODServiceListViewController class];
    }
    return nil;
}

@end
