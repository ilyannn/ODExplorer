//
//  ODResource+Collection.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollection.h"
#import "LazyMutableArray.h"

/// Internal information about properties and methods of ODResource availible only for collections.
@interface ODResource (Collection) <ODCollection, LazyMutableArrayDelegate>

- (LazyMutableArray *)childrenArrayForCollection;
- (NSError *)parseFromJSONArray:(NSArray *)array;
- (NSError *)parseServiceDocumentFromArray:(NSArray *)array;
- (void)dropElementsOfCollectionRecursively:(BOOL)recursively;
@end
