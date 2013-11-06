//
//  ODServiceList.m
//  OIDataNorth
//
//  Created by ilya on 10/25/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceList.h"
#import "ODResource_Internal.h"

#import "ODOperation.h"
#import "ODCollection.h"

@implementation ODResourceList

- (NSString *)shortDescription {
    return nil;
}

- (void)addResourceToList:(ODResource *)resource {
    ODOperation *operation = [ODOperation new];
    [operation addOperationStep:^NSError *(id op) {
        [self.childrenArray addObject:[ODResource resourceByURLCopy:resource in:self.retrievalInfo]];
        return nil;
    }];
    [self handleOperation:operation];
}

- (void)removeResourceFromList:(ODResource *)resource {
    ODOperation *operation = [ODOperation new];
    [operation addOperationStep:^NSError *(id op) {
        [self.childrenArray removeObject:resource];
        return nil;
    }];
    [self handleOperation:operation];
}

- (void)retrieve {
    
}

- (void)retrieveMetadata {
    for (ODResource<ODCollectionAccessing> *resource in self.childrenArray) {
        [resource retrieveMetadata];
    }
}

@end
