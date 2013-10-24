//
//  OIMasterViewController.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollectionViewController.h"

#import "ODCollectionCache.h"
#import "ODEntityTableViewCell.h"
#import "ODEntityViewController.h"

NSString * const ODEntityCellReuseID = @"EntityCell";

@interface ODCollectionViewController ()
@end

@implementation ODCollectionViewController {
    ODCollectionCache *collectionCache;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];

    collectionCache = [ODCollectionCache new];
    collectionCache.collection = self.resource;
    
    [self refreshData];
}

- (void)loadView {
    [super loadView];
    
    [self.tableView registerClass:[self entityCellClass] forCellReuseIdentifier:ODEntityCellReuseID];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPageCurl target:self action:@selector(refreshData)];;
}

- (Class)entityCellClass {
    return [ODEntityTableViewCell class];
}

- (void)refreshData {
    [self.resource retrieveCount];
}

- (void)subscribeToResource {
    [self.resource addObserver:self forKeyPath:@"count"
                    options:NSKeyValueObservingOptionInitial context:nil];
}

- (void)unsubscribeFromResource {
    [self.resource removeObserver:self forKeyPath:@"count"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (self.resource.count != [self.tableView numberOfRowsInSection:0]) {
        [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                         withObject:nil waitUntilDone:NO
         ];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ODEntityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ODEntityCellReuseID forIndexPath:indexPath];

    cell.headlineProperties = self.headlineProperties;
    ODEntity *entity = collectionCache[indexPath.row];
    cell.resource = entity;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showEntity"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ODResourceViewController *target = [segue destinationViewController];
        [target setResource:collectionCache[indexPath.row]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ODEntityTableViewCell *cell = (ODEntityTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (![cell isKindOfClass:[ODEntityTableViewCell class]]) return;
    ODEntityViewController *vc = [ODEntityViewController new];
    vc.resource = cell.resource;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
