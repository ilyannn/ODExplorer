//
//  ODResource+Collection.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollection.h"
#import "CollectionCache.h"

@class CollectionCache;

/// Internal information about properties and methods of ODResource availible only for collections.
@interface ODResource (Collection) <ODCollectionAccessing, ODCollectionCacheDelegate>

- (CollectionCache *)childrenArrayForCollection;
- (NSError *)parseFromJSONArray:(NSArray *)array;
- (NSError *)parseServiceDocumentFromArray:(NSArray *)array;

@end
