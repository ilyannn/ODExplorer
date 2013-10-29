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

@implementation ODCollectionViewController {
    ODCollectionCache *collectionCache;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    
    //     self.navigationItem.leftBarButtonItem = self.editButtonItem;
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(refreshChildren)];;
    
    collectionCache = [ODCollectionCache new];
    collectionCache.collection = self.resource;
    
    [super viewDidLoad];
}

- (NSDictionary *)cellClasses {
    NSMutableDictionary *dict =[[super cellClasses] mutableCopy];
    dict[ODGenericCellReuseID] = [ODEntityTableViewCell class];
    return dict;
}

- (void)refreshChildren {
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
//        [self.tableView performSelectorOnMainThread:@selector(reloadData)
//                                         withObject:nil waitUntilDone:NO
//         ];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resource.count + !!self.loadingRowPresent;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.loadingRowPresent && (indexPath.row == self.loadingRowIndex)) {
        return [tableView dequeueReusableCellWithIdentifier:ODLoadingCellReuseID forIndexPath:indexPath];
    }

    ODEntityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ODGenericCellReuseID forIndexPath:indexPath];
    ODEntity *entity = collectionCache[indexPath.row - !!(self.loadingRowPresent && (indexPath.row > self.loadingRowIndex)) ];
    
    if (!self.headlineProperties) {
        self.headlineProperties = [NSMutableArray new];
        NSString *guessed = [collectionCache guessMediumDescriptionProperty];
        if (guessed) [self.headlineProperties addObject:guessed];
    }
    
    cell.headlineProperties = self.headlineProperties;
    cell.resource = entity;
    
    return cell;
}

- (void)update {
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


@end
