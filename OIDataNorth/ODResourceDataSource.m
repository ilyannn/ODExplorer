//
//  ODResourceDataSource.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceDataSource.h"

#import "ODRetrieving_Objects.h"

#import "ODLoadingTableViewCell.h"
#import "ODPropertyTableViewCell.h"
#import "ODGenericTableViewCell.h"
#import "ODEntityTableViewCell.h"

NSString *const ODGenericCellReuseID = @"GenericCell";
NSString *const ODLoadingCellReuseID = @"LoadingCell";
NSString *const ODPrimitiveCellReuseID = @"PropertyCell";
NSString *const ODBracketedCellReuseID = @"BracketedCell";

@implementation ODResourceDataSource

- (instancetype)initWithResource:(id<ODResource>)resource {
    if (self = [self init]) {
        _resource = resource;
    }
    return self;
}

- (NSDictionary *)cellClasses {
    static NSDictionary *classes;
    if (!classes) {
        classes = @{ ODGenericCellReuseID : [ODGenericTableViewCell class],
                     ODLoadingCellReuseID : [ODLoadingTableViewCell class],
                     ODPrimitiveCellReuseID : [ODPropertyTableViewCell class],
                     ODBracketedCellReuseID : [ODEntityTableViewCell class] };
    }
    return classes;
}

- (NSString *)cellIDForResource:(ODResource *)child {
    if ([child isPrimitiveProperty])
        return ODPrimitiveCellReuseID;
    
    if ([child.retrievalInfo isKindOfClass:[ODRetrievalByBrackets class]]
        || ([child.retrievalInfo isKindOfClass:[ODRetrieveByURL class]] && ![child.retrievalInfo isRootURL])) {
        return ODBracketedCellReuseID;
    }
    
    return ODGenericCellReuseID;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resource.childrenArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    id resourceID = self.resource.childrenArray[indexPath.row];
    ODResourceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[self cellIDForResource:resourceID]
                                                                    forIndexPath:indexPath];
    cell.resource = resourceID;
    return cell;
}



@end
