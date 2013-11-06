//
//  ODCollectionType.h
//  OIDataNorth
//
//  Created by ilya on 11/5/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODNamedType.h"

@interface ODCollectionType : ODType

+ (instancetype)collectionWithElements:(ODType *)elementType;
- (instancetype)initWithElementType:(ODType *)elementType;
@property (readonly) ODNamedType *elementType;

@end
