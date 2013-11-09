//
//  ODResourceDataSource.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODBaseResourceDataSource.h"

#import "ODRetrieving_Objects.h"
#import "ODResource+CollectionFields.h"

#import "ODPropertyTableViewCell.h"
#import "ODGenericTableViewCell.h"
#import "ODEntityTableViewCell.h"

NSString *const ODGenericCellReuseID = @"GenericCell";
NSString *const ODPrimitiveCellReuseID = @"PropertyCell";
NSString *const ODBracketedCellReuseID = @"BracketedCell";


@implementation ODBaseResourceDataSource {
    NSMutableArray *headlineProperties;
}

- (instancetype)initWithResource:(id<ODResource>)resource {
    if (self = [self init]) {
        _resource = resource;
    }
    return self;
}

- (NSDictionary *)cellClasses {
    return @{          ODGenericCellReuseID : [ODGenericTableViewCell class],
                     ODPrimitiveCellReuseID : [ODPropertyTableViewCell class],
                     ODBracketedCellReuseID : [ODEntityTableViewCell class]
    };
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
    [self configureCell:cell];
    return cell;
}

- (void)configureCell:(id)cell {
    if (self.resource.kind == ODResourceKindCollection
        && [cell respondsToSelector:@selector(setHeadlineProperties:)]) {
        
        if (!headlineProperties) {
            NSString *guess = [self.resource performSelector:@selector(guessMediumDescriptionProperty)];
            headlineProperties = [@[guess] mutableCopy];
        }
        
        [cell performSelector:@selector(setHeadlineProperties:) withObject:headlineProperties];
    }
}


@end
