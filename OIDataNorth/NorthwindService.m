//
//  NorthwindService.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "NorthwindService.h"

@implementation NorthwindService

- (NSURL *)URL {
    return [NSURL URLWithString:@"http://services.odata.org/V3/Northwind/Northwind.svc/"];
}

- (OIDataCollection *)Products {
    return [self getCollection:@"Products"];
}

@end
