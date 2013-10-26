//
//  ODPlainOperation.h
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperation.h"

@interface ODPlainOperation : ODOperation

/// This method is called once response has been successfully converted to string.
- (NSError *)processPlainResponse:(NSString *)responseString;

@end
