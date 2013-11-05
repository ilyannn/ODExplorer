//
//  OIDataCollection.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"

@class ODCountOperation, ODMetadataOperation;

/// Public information about properties and methods of ODResource availible only for collections.
@protocol ODCollectionAccessing <ODResourceAccessing>
- (NSError *)updateFromJSONArray:(NSArray *)array;

- (void)countCollection;
- (ODCountOperation *)countCollectionOperation;

- (void)retrieveMetadata;
- (ODMetadataOperation *)retrieveMetadataOperation;

// - (ODEntity *)objectAtIndexedSubscript:(NSUInteger)index;

// - (void)list:(NSUInteger)top from:(NSUInteger)skip expanding:(NSString *)expanding perform:(void (^)(NSArray *items))block;

@end

@class ODEntity, ODPrimitiveType;

/// A class that works essentially as a hint to compiler.
@interface ODCollection : ODResource <ODCollectionAccessing>


/* + (instancetype)collectionForProperty:(NSString *)propertyName
                           entityType:(ODEntityType *)entityType
                             inEntity:(ODEntity *)entity;
*/

@end
