//
//  Product.h
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntity.h"
#import "Supplier.h"

@interface Product : ODEntity

@property NSString *ProductName;
@property NSNumber *ProductID;
@property NSNumber *SupplierID;
@property NSNumber *CategoryID;
@property NSNumber *UnitPrice;
@property NSNumber *Discontinued;

@property (readonly, nonatomic) Supplier *Supplier;
@end
