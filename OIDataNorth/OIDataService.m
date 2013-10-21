//
//  OIDataService.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataService.h"
#import "OIDataCollection.h"

@implementation OIDataService

- (NSURL *)URL {
    return [NSURL URLWithString:self.servicePath relativeToURL:self.hostURL];
}

- (OIDataCollection *)getCollection:(NSString *)collectionName {
    OIDataCollection *collection = [OIDataCollection new];
    collection.parent = self;
    collection.name = collectionName;
    return collection;
}

@end
