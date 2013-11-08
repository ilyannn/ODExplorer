//
//  OIDataCollection.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"
#import "ODCollection_Protocol.h"

/// A class that works essentially as a hint to compiler.
@interface ODCollection : ODResource <ODCollection>


/* + (instancetype)collectionForProperty:(NSString *)propertyName
                           entityType:(ODEntityType *)entityType
                             inEntity:(ODEntity *)entity;
*/

@end
