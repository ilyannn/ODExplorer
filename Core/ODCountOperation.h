//
//  ODCountOperation.h
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPlainOperation.h"

@interface ODCountOperation : ODPlainOperation
@property (readonly) NSUInteger responseCount;
@end
