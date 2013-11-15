//
//  ODRetrieveOperation.h
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODJSONOperation.h"

@class ODEntity;

@interface ODRetrieveOperation : ODJSONOperation
@property ODResourceKind responseKind;
@property NSArray *responseList;
@property (getter = isServiceDocument) BOOL serviceDocument;

@property BOOL indeterminateCount;
@end
