//
//  ODServiceViewController.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODServiceViewController.h"
#import "ODResourceTableViewCell.h"

@implementation ODServiceViewController

- (void)refreshChildren {
    [self.resource retrieveEntitySets];
}

- (void)configureCell:(ODResourceTableViewCell *)cell forChild:(id)childID {
    cell.resource = self.resource.entitySets[childID];
}

/*
- (void)subscribeToResource {
    [self.resource addObserver:self forKeyPath:@"entitySets"
                       options:NSKeyValueObservingOptionInitial context:nil];
}

- (void)unsubscribeFromResource {
    [self.resource removeObserver:self forKeyPath:@"entitySets"];
}
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
}

- (void)update {
    if (self.resource.entitySets.count != [self.tableView numberOfRowsInSection:0]) {
        self.childIdentifiers = [[self.resource.entitySets allKeys] sortedArrayUsingComparator: ^NSComparisonResult (NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2];
        }];
        
        [self.tableView reloadData];
        
/*        [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                         withObject:nil waitUntilDone:NO
         ];
*/
    }
}

@end
