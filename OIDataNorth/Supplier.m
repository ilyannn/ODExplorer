//
//  Supplier.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "Supplier.h"
#import "ODCollection.h"
#import "Product.h"
#import "ODCustomEntityType.h"

NSString *kSupplier_Products = @"Products";

@implementation Supplier {
    __weak ODCollection *_Products;
}

@dynamic SupplierID, ContactName, ContactTitle, CompanyName;

- (ODCollection *)Products {
    if (!_Products) {
        _Products = [self navigationCollection:kSupplier_Products entityType:[Product customEntityType]];
    }
    return _Products;
}

@end
