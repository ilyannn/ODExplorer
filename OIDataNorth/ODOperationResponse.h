//
//  ODOperationResponse.h
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ODOperationResponse : NSObject

@property NSURLRequest *request;
@property NSHTTPURLResponse *HTTPResponse;
@property NSError *HTTPError;
@property NSData* data;

@property (readonly) NSInteger majorProtocolVersion;

@end
