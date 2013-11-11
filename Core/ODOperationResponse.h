//
//  ODOperationResponse.h
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

/// This class encapsulates an idea of URL response. It's usually, but not always,
/// used for HTTP requests.
@interface ODOperationResponse : NSObject

/// Should be left blank for non-HTTP requests.
@property NSHTTPURLResponse *HTTPResponse;

@property NSData* data;

@property (readonly) NSInteger majorProtocolVersion;
@property (readonly) NSInteger maxMajorProtocolVersion;
@property (readonly) NSInteger majorStatus;
@property (readonly) NSString *contentType;
- (BOOL)isJSON;
- (BOOL)isVerbose;

/// The errors are communicated by HTTP codes.
/// If we're not retrieveing by HTTP, we're always successful.
- (NSError *)statusCodeError;


@end
