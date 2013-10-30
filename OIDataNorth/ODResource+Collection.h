//
//  ODResource+Collection.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollection.h"

@class CollectionProxy;

/// Internal information about properties and methods of ODResource availible only for collections.
@interface ODResource (Collection) <ODCollectionAccessing>
- (CollectionProxy *)childrenArrayForCollection;
- (NSError *)parseFromJSONArray:(NSArray *)array;
@end
