//
//  Product.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

NSString *const kProduct_ProductName = @"ProductName";
NSString *const kProduct_ProductID = @"ProductID";
NSString *const kProduct_Supplier = @"Supplier";

#import "Product.h"
#import "Supplier.h"

@implementation Product {
    __weak Supplier *_Supplier;
}

@dynamic SupplierID, CategoryID, UnitPrice, Discontinued;

- (NSString *)ProductName {
    id object = [self valueForKey:kProduct_ProductName];
    return [object isKindOfClass:NSString.class] ? object : nil;
}

- (NSNumber *)ProductID {
    id object = [self valueForKey:kProduct_ProductID];
    return [object isKindOfClass:NSNumber.class] ? object : nil;
}

- (void)setProductName:(NSString *)ProductName {
    [self setValue:ProductName forKey:kProduct_ProductName];
}

- (void)setProductID:(NSNumber *)ProductID {
    [self setValue:ProductID forKey:kProduct_ProductID];
}

/*
- (Supplier *)Supplier {
    return [self navigationProperty:kProduct_Supplier propertyType:[Supplier entityType]];
}
*/

@end
