//
//  ODEntityRetrieval.h
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrievalInfo.h"

@class ODEntitySet, ODCollection, ODEntity;


@interface ODEntityRetrieval : ODRetrievalInfo
@end


@interface ODEntityRetrievalByKeys : ODEntityRetrieval
@property ODEntitySet *entitySet;
@end


