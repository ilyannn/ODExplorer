//
//  OIDataRetrieveCollection.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataRetrieveCollection.h"

const NSString *kOIDataQuerySelectString = @"$select";
const NSString *kOIDataQueryFilterString = @"$filter";
const NSString *kOIDataQueryOrderByString = @"$orderby";


@implementation OIDataRetrieveCollection

- (id)filter {
    return self.parameters[kOIDataQueryFilterString];
}

- (id)orderBy {
    return self.parameters[kOIDataQueryOrderByString];
}

- (id)select {
    return self.parameters[kOIDataQuerySelectString];
}

- (void)setSelect:(id)select {
    self.parameters[kOIDataQuerySelectString] = [select description];
}

- (void)setFilter:(id)filter {
    self.parameters[kOIDataQueryFilterString] = [filter description];
}

- (void)setOrderBy:(id)orderBy {
    self.parameters[kOIDataQueryOrderByString] = [orderBy description];
}

@end
