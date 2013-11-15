//
//  ODResourceViewController.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODBaseResourceViewController.h"

#import "ODResourceTableViewCell.h"
#import "ODBaseResourceDataSource.h"
#import "ODResource+CollectionFields.h"
#import "ODRouting.h"

#import "ODResource.h"

@implementation ODBaseResourceViewController {
    ODResource *_resource;
}

#pragma mark - View Construction

+ (instancetype)controllerForResource:(id <ODResource>)resource {
    return !resource ? nil : [[self alloc] initWithResource:resource];
}

- (instancetype)initWithResource:(id <ODResource> )resource {
    if (self = [super init]) {
        self.resource = resource;
        [self configure];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = [self.resource shortDescription];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    id cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(resource)]) {
        [self pushResource:[cell resource]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.resource dropChildrenRecursively:YES];
}

- (id<ODResource>)resource {
    return _resource;
}

- (void)setResource:(id<ODResource>)resource {
    if (resource != _resource) {
        _resource = resource;
        [self configure];
        [self update];
    }
}


#pragma mark - Configuration

// If you redefine -configure to instantiate controller with different classes AND
// call -setResource, then you should manually register those classes with tableView.
- (void)configure {
    _resourceDataSource = [self resourceDataSourceFactory];
    
    [[self.resourceDataSource cellClasses] enumerateKeysAndObjectsUsingBlock:
     ^(NSString *key, Class obj, BOOL *stop) {
         [self.tableView registerClass:obj forCellReuseIdentifier:key];
     }
     ];

    self.tableView.dataSource = self.resourceDataSource;
}

- (ODBaseResourceDataSource *)resourceDataSourceFactory {
    return [[ODBaseResourceDataSource alloc] initWithResource:self.resource];
}

- (void)update {
    [self.tableView reloadData];
}

- (void)pushResource:(id<ODResource>)resource {
    UIViewController *vc = [[self class] controllerForResource:resource];
    if (vc) {
        (void)[self.navigationController popToViewController:self animated:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
