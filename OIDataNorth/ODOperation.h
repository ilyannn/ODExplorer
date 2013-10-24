//
//  OIDataQuery.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODService.h"
#import "AFNetworking/AFNetworking.h"

// This is contructed from parameters, then you use its |URLRequest| property
// This is an abstract class; specific operations are subclasses.

@interface ODOperation : NSOperation

+ (instancetype)operationWithResource: (ODResource *)resource;

- (NSString *)method;

@property (readonly) AFHTTPResponseSerializer <AFURLResponseSerialization> *responseSerializer;
@property (readonly) AFHTTPRequestSerializer *requestSerializer;


@property (nonatomic) ODResource *resource;
@property NSMutableDictionary *parameters;

@property (nonatomic, readonly) NSURL *URL;
@property (strong) void(^onSuccess)(ODOperation *operation);

@property (readonly, nonatomic) NSMutableURLRequest *request;

- (void)processResponse:(NSHTTPURLResponse *)response data:(NSData *)data;

@end
