//
//  ODCollection_Protocol.h
//  OIDataNorth
//
//  Created by ilya on 11/8/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource_Protocol.h"

@class ODCountOperation, ODMetadataOperation;

/// Public information about properties and methods of ODResource availible only for collections.
@protocol ODCollection <ODResource>
- (NSError *)updateFromJSONArray:(NSArray *)array;

- (void)countCollection;
- (ODCountOperation *)countCollectionOperation;

- (void)retrieveMetadata;
- (ODMetadataOperation *)retrieveMetadataOperation;

// - (ODEntity *)objectAtIndexedSubscript:(NSUInteger)index;

// - (void)list:(NSUInteger)top from:(NSUInteger)skip expanding:(NSString *)expanding perform:(void (^)(NSArray *items))block;

@end