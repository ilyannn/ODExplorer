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

// A factory to create operations. Note that subclasses should be chaging its singnature
// to match that of |resource| property.
+ (instancetype)operationWithResource:(ODResource *)resource;

#pragma mark - What do we access?
// These properties are set to describe the operation. |parameters| can be accessed by KVO coding.

// The resource with which the operation is being performed.
@property (nonatomic) ODResource *resource;

// This is mutable by default; if you change it to immutable, you won't be able to set parameters.
@property NSDictionary *parameters;
- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;


#pragma mark - How do we access it?
// These methods should be overridden in subclasses to describe how the operation 'works'.

// The HTTP method to access the resource. Defaults to GET.
- (NSString *)method;

// Method to construct the URL. Defaults to resource URL.
- (NSURL *)URL;

// Additional header fields. Those are added, value-by-value, to existing HTTP Headers.
// Defaults to nil.
- (NSDictionary *)addedHTTPHeaders;

// Serializer to construct the request.
// - (AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer;
// @property (readonly) AFHTTPRequestSerializer *requestSerializer;


#pragma mark - What do we do with the results?

- (void)processResponse:(NSHTTPURLResponse *)response data:(NSData *)data;
@property (strong) void (^onSuccess)(ODOperation *operation);


@end
