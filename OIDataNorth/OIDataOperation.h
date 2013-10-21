//
//  OIDataQuery.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataService.h"

// This is contructed from parameters, then you use its |URLRequest| property
// This is an abstract class; specific operations are subclasses.

@interface OIDataOperation : NSObject

@property (readwrite, nonatomic) OIDataResource *resource;

@property NSMutableDictionary *parameters;

@property (readonly, nonatomic) NSString *method;
@property (readonly, nonatomic) NSURLRequest *URLRequest;

@end
