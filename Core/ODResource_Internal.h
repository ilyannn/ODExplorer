//
//  ODResource_Internal.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"

@interface ODResource () 

@property id resourceValue;
@property NSArray *childrenArray; 
@property id<ODRouting> retrievalInfo;

@property (nonatomic) NSMutableDictionary *remoteProperties;
@property (nonatomic) NSMutableDictionary *navigationProperties;

@end