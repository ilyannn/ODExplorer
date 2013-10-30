//
//  ODResourceViewController.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceViewController.h"
#import "ODResourceTableViewCell.h"
#import "ODRetrievalInfo.h"
#import "ODNotifyingManager.h"

#import "ODLoadingTableViewCell.h"
#import "ODPropertyTableViewCell.h"
#import "ODCollectionTableViewCell.h"
#import "ODEntityTableViewCell.h"

#import "ODResourceViewControllerMenu.h"
#import "ODOperation.h"

#import "ODResource+CollectionFields.h"

NSString *const ODGenericCellReuseID = @"GenericCell";
NSString *const ODLoadingCellReuseID = @"LoadingCell";
NSString *const ODPropertyCellReuseID = @"PropertyCell";
NSString *const ODEntitySetCellReuseID = @"GenericCell";
NSString *const ODServiceCellReuseID = @"GenericCell";
NSString *const ODEntityCellReuseID = @"EntityCell";
NSString *const ODCollectionCellReuseID = @"CollectionCell";

@implementation ODResourceViewController

#pragma mark - View and Actions

+ (ODResourceViewController *)controllerForResource:(ODResource *)resource {
    Class vcClass = [self viewControllerClassFor:resource];
    if (!vcClass) return nil;
    
    ODResourceViewController *vc = [vcClass new];
    if (![vc isKindOfClass:[ODResourceViewController class]]) return nil;
    
    vc.resource = resource;
    return vc;
}

- (void)displayActionMenu {
    ODResourceViewControllerMenu *actionMenu = [ODResourceViewControllerMenu sharedMenu];
    actionMenu.resource = self.resource;
    [actionMenu.actionSheet showFromBarButtonItem:self.actionButton animated:YES];
}

- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    
    [[self cellClasses] enumerateKeysAndObjectsUsingBlock: ^(NSString *key, Class obj, BOOL *stop) {
        [self.tableView registerClass:obj forCellReuseIdentifier:key];
    }];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                            target:self
                                                                            action:@selector(displayActionMenu)];
    self.navigationItem.rightBarButtonItem = button;
    self.actionButton = button;
}

- (void)refreshControlActivated {
    [self refreshChildren];
    [self.refreshControl endRefreshing];
}

- (void)refreshChildren {
    [self.resource retrieve];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = [self.resource shortDescription];
    self.subscribed = YES;
    
    if (!self.refreshControl) {
        self.refreshControl = [UIRefreshControl new];
        [self.refreshControl
         addTarget:self
         action:@selector(refreshControlActivated)
         forControlEvents:UIControlEventValueChanged];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    self.subscribed = NO;
    [super viewWillDisappear:animated];
}

#pragma mark - Constructing table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resource.childrenArray count] + !!self.loadingRowPresent;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ODResourceTableViewCell *cell = (ODResourceTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (![cell isKindOfClass:[ODResourceTableViewCell class]]) return;
    
    ODResourceViewController *vc = [[self class] controllerForResource:cell.resource];
    if (!vc) return;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.loadingRowPresent && (indexPath.row == self.loadingRowIndex)) {
        return [tableView dequeueReusableCellWithIdentifier:ODLoadingCellReuseID forIndexPath:indexPath];
    }
    
    id resourceID = [self childIDForIndexPath:indexPath];
    NSString *cellID = [self cellIDForResource:resourceID];
    
    id cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [self configureCell:cell forChild:resourceID];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return !(self.loadingRowPresent && self.loadingRowIndex == indexPath.row);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}

- (void)configureCell:(id)cell forChild:(ODResource *)childID {
    if ([cell respondsToSelector:@selector(setHeadlineProperties:)] && self.resource.kind == ODResourceKindCollection) {
        if (!self.headlineProperties) {
            self.headlineProperties = [NSMutableArray new];
            NSString *guessed = [self.resource guessMediumDescriptionProperty];
            if (guessed) [self.headlineProperties addObject:guessed];
        }
        
        [cell setHeadlineProperties:self.headlineProperties];
    }
    [cell setResource:childID];
}

- (id)childIDForIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    row -= self.loadingRowPresent && (row > self.loadingRowIndex);
    return self.resource.childrenArray[row];
}

- (void)setLoadingRowPresent:(BOOL)loadingRowPresent {
    if (_loadingRowPresent != loadingRowPresent) {
        _loadingRowPresent = loadingRowPresent;
        
        if (self.loadingRowIndex >= 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.loadingRowIndex inSection:0];
            if (!loadingRowPresent) {
                [self.tableView reloadData];
                //            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            } else {
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    }
}

#pragma mark - Updating data

- (void)setResource:(ODResource *)resource {
    if (resource != _resource) {
        BOOL wasSubscribed = self.subscribed;
        self.subscribed = NO;
        
        _resource = [resource autoretrieve];
        [(ODRetrievalInfo *)(_resource.retrievalInfo)addManager :[[ODNotifyingManager alloc] initWithDelegate:self]];
        
        // this should automatically start refresh as well
        self.subscribed = wasSubscribed;
    }
}

- (void)setSubscribed:(BOOL)subscribed {
    if (subscribed != _subscribed) {
        _subscribed = subscribed;
        /*        if (subscribed) {
         [self subscribeToResource];
         } else {
         [self unsubscribeFromResource];
         }
         */
    }
}

- (void)manager:(ODNotifyingManager *)manager willStart:(ODOperation *)operation {
    if (operation.retrievalInfo == self.resource.retrievalInfo && !self.loadingRowPresent) {
        self.loadingRowPresent = YES;
    }
}

- (void)manager:(ODNotifyingManager *)manager didFinish:(ODOperation *)operation {
    if (operation.retrievalInfo == self.resource.retrievalInfo && self.loadingRowPresent) {
        self.loadingRowPresent = NO;
    }
    [self update];
}

- (void)update {
    [self.tableView reloadData];
}

#pragma mark - Class Configuration

/// Override this to customize child view controllers.
+ (Class)viewControllerClassFor:(ODResource *)resource {
    return [ODResourceViewController class];
}

- (NSString *)cellIDForResource:(ODResource *)child {
    switch (child.kind) {
        case ODResourceKindEntity: return ODEntityCellReuseID;
            
        case ODResourceKindUnknown: if ([child.retrievalInfo isKindOfClass:[ODRetrievalOfProperty class]])
            return ODPropertyCellReuseID;
            
        case ODResourceKindCollection: return ODCollectionCellReuseID;
    }
}

- (NSDictionary *)cellClasses {
    static NSDictionary *classes;
    if (!classes) {
        classes = @{ ODCollectionCellReuseID : [ODCollectionTableViewCell class],
                     ODLoadingCellReuseID : [ODLoadingTableViewCell class],
                     ODPropertyCellReuseID : [ODPropertyTableViewCell class],
                     ODEntityCellReuseID : [ODEntityTableViewCell class] };
    }
    return classes;
}

@end
