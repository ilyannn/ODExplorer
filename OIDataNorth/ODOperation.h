//
//  OIDataQuery.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "AFNetworking/AFNetworking.h"

#import "OperationWithSteps.h"

#import "ODOperationResponse.h"
#import "ODResource.h"

/// This is contructed from parameters, then you use its URLRequest property
/// This is an abstract class; specific operations are its subclasses.
@interface ODOperation : OperationWithSteps

/// A factory to create operations. Note that subclasses should be chaging its signature
/// to match that of resource property.
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

/// Check the operation's parameters.
- (NSError *)validate;

/// The HTTP method to access the resource. Defaults to GET.
- (NSString *)method;

/// Method to construct the URL. Defaults to resource URL.
- (NSURL *)URL;

/// Additional header fields. Those are added, value-by-value, to existing HTTP Headers.
- (NSDictionary *)addedHTTPHeaders;


#pragma mark - What do we do with the results?
/// There are quite a few steps that can fail in the process of performing an operation.
@property NSError *error;

- (NSError *)processResponse:(ODOperationResponse *)response;



@end
