//
//  Supplier.h
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntity.h"

@class ProductCollection;

@interface Supplier : ODEntity

@property NSNumber *SupplierID;
@property NSString *CompanyName;
@property NSString *ContactName;
@property NSString *ContactTitle;

@property (readonly) ODCollection *Products;

@end
