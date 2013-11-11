//
//  OIDataEntry.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"
#import "ODEntity_Protocol.h"

@class ODCustomEntityType;

/// A class that works essentially as a hint to compiler.
@interface ODEntity : ODResource <ODEntity>
@end