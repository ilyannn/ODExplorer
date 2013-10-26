//
//  ODResourceViewController.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceViewController.h"
#import "ODResourceTableViewCell.h"

NSString *const ODGenericCellReuseID = @"GenericCell";

@implementation ODResourceViewController

+ (ODResourceViewController *)controllerForResource:(ODResource *)resource {
    Class vcClass = [self viewControllerClassFor:resource];
    if (!vcClass) return nil;
    
    ODResourceViewController *vc = [vcClass new];
    if (![vc isKindOfClass:[ODResourceViewController class]]) return nil;
    
    vc.resource = resource;
    return vc;
}

- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    
    [[self cellClasses] enumerateKeysAndObjectsUsingBlock: ^(NSString *key, Class obj, BOOL *stop) {
        [self.tableView registerClass:obj forCellReuseIdentifier:key];
    }];
    
    [self refreshChildren];
}

- (NSDictionary *)cellClasses {
    return @{ ODGenericCellReuseID : [ODResourceTableViewCell class] };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = [self.resource shortDescription];
    self.subscribed = YES;
    if (!self.refreshControl) {
        self.refreshControl = [UIRefreshControl new];
        [self.refreshControl addTarget:self action:@selector(refreshControlActivated) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)refreshControlActivated {
    [self refreshChildren];
    [self.refreshControl endRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.subscribed = NO;
    [super viewWillDisappear:animated];
}

- (void)setResource:(ODResource *)resource {
    if (resource != _resource) {
        BOOL wasSubscribed = self.subscribed;
        self.subscribed = NO;
        _resource = resource;
        // this should automatically start refresh as well
        self.subscribed = wasSubscribed;
    }
}

- (void)setSubscribed:(BOOL)subscribed {
    if (subscribed != _subscribed) {
        _subscribed = subscribed;
        if (subscribed) {
            [self subscribeToResource];
        } else {
            [self unsubscribeFromResource];
        }
    }
}

- (void)refreshChildren {
}

- (void)subscribeToResource {
}

- (void)unsubscribeFromResource {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.childIdentifiers.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ODResourceTableViewCell *cell = (ODResourceTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (![cell isKindOfClass:[ODResourceTableViewCell class]]) return;
    
    ODResourceViewController *vc = [[self class] controllerForResource:cell.resource];
    if (!vc) return;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id childIdentifier = self.childIdentifiers[indexPath.row];
    NSString *cellID = [self cellReuseIDForChild:childIdentifier];
    ODResourceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [self configureCell:cell forChild:childIdentifier];
    return cell;
}

- (NSString *)cellReuseIDForChild:(id)childID {
    return ODGenericCellReuseID;
}

- (void)configureCell:(ODResourceTableViewCell *)cell forChild:(id)childID {
    cell.resource = childID;
}

@end
