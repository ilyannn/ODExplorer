//
//  NorthwindService.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODService.h"
#import "ODEntitySet.h"

@interface NorthwindService : ODService
@property (readonly) ODEntitySet *Products, *Customers, *Employees;

@end
