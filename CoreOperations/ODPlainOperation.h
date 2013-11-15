//
//  ODPlainOperation.h
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODHTTPOperation.h"

@interface ODPlainOperation : ODHTTPOperation

/// This method is called once response has been successfully converted to string.
@property (readonly) NSString *responsePlain;
- (NSError *)processPlainResponse;

@end
