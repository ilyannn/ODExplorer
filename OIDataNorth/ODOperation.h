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

#define MIN_ODATA_MAJOR_VERSION 3
#define MAX_ODATA_MAJOR_VERSION 3

/// Encapsulates an idea of sending certain request and processing the parameters.
/// The operation consists of steps; each step can bring us closer to this goal.
@interface ODOperation : OperationWithSteps

/// A factory to create operations. Note that not all operations work for all kinds of resources.
+ (instancetype)operationWithResource:(ODResource *)resource;
+ (NSError *)errorForKind:(ODResourceKind)kind;


#pragma mark - What do we access?
// These properties are set to describe the operation. |parameters| can be accessed by KVO coding.

// The resource with which the operation is being performed.
//@property (nonatomic) ODResource *resource;
@property (nonatomic) id<ODRetrieving> retrievalInfo;

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

/// Additional header fields. Those start with existing HTTP Headers. [super ...] is recommended.
- (void)changeHTTPHeaders:(NSMutableDictionary *)headers;

/// Method to combine request parameters into request.
- (NSError *)prepareRequest;

/// Resulting URL request.
@property NSURLRequest *request;

/// Synchronous getting of response.
- (NSError *)responseFromRequest;

#pragma mark - What do we do with the results?
/// There are quite a few steps that can fail in the process of performing an operation.

/// Combines returned response fields into one object.
@property ODOperationResponse *response;

/// Final step in the processing sequence.
- (NSError *)processResponse;

@end
