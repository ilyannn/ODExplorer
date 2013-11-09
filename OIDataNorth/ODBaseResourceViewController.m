//
//  ODResourceViewController.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODBaseResourceViewController.h"

#import "ODResourceTableViewCell.h"
#import "ODResourceDataSource.h"
#import "ODResource+CollectionFields.h"

@interface ODBaseResourceViewController ()
@property ODResourceDataSource *resourceDataSource;
@end

@implementation ODBaseResourceViewController {
    NSMutableArray *headlineProperties;
}

#pragma mark - View Construction

+ (instancetype)controllerForResource:(id <ODResource> )resource {
    return !resource ? nil : [[self alloc] initWithResource:resource];
}

- (instancetype)initWithResource:(id <ODResource> )resource {
    if (self = [super init]) {
        _resource = resource;
        [self configure];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.resourceDataSource cellClasses] enumerateKeysAndObjectsUsingBlock:
     ^(NSString *key, Class obj, BOOL *stop) {
         [self.tableView registerClass:obj forCellReuseIdentifier:key];
     }
     ];
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

#pragma mark - Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resourceDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [self.resourceDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    [self configureCell:cell];
    return cell;
}

#pragma mark - Updating data

- (void)setResource:(ODResource *)resource {
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
    self.resourceDataSource = [[ODResourceDataSource alloc] initWithResource:self.resource];
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

#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)configureCell:(id)cell {
    if (self.resource.kind == ODResourceKindCollection) {
        SEL sel = @selector(setHeadlineProperties:);
        SEL seld = @selector(guessMediumDescriptionProperty);
        
        if ([cell respondsToSelector:sel] && [self.resource respondsToSelector:seld]) {
            if (!headlineProperties) {
                headlineProperties = [[NSMutableArray alloc] initWithObjects:[self.resource performSelector:seld], nil];
            }
            
            [cell performSelector:sel withObject:headlineProperties];
        }
    }
}

@end
