//
//  ODJSONOperation.h
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODHTTPOperation.h"

@interface ODJSONOperation : ODHTTPOperation

@property (readonly) id JSONResponse;
/// This method is called once response has been successfully read as JSON.
- (NSError *)processJSONResponse;

@end
