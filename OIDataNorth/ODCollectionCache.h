//
//  ODCachedCollection.h
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollection.h"

@interface ODCollectionCache : NSObject

@property ODCollection *collection;
@property NSString *expand;

- (NSUInteger)count;
- (id)objectAtIndexedSubscript:(NSUInteger)index;

- (void)performCount;

- (NSString *)guessMediumDescriptionProperty;

@property (readonly) NSOperationQueue *operationQueue;

@end
