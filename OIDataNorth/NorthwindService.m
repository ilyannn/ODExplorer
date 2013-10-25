//
//  NorthwindService.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "NorthwindService.h"

#import "ODCollection.h"
#import "Product.h"
#import "Customer.h"
#import "Employee.h"

@implementation NorthwindService

- (NSString *)shortDescription {
    return @"Northwind Service";
}

- (NSURL *)URL {
    return [NSURL URLWithString:@"http://services.odata.org/V3/Northwind/Northwind.svc/"];
}

- (id)init {
    self = [super init];
    if (self) {
/*        _Products  = [ODEntitySet entitySetWithService:self name:@"Products" entityType:[Product entityType]];
        _Customers = [ODEntitySet entitySetWithService:self name:@"Customers" entityType:[Customer entityType]];
        _Employees = [ODEntitySet entitySetWithService:self name:@"Employees" entityType:[Employee entityType]];
*/    }
    return self;
}

@end
