//
//  ODJSONOperation.h
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperation.h"

@interface ODJSONOperation : ODOperation

@property id JSONResponse;
/// This method is called once response has been successfully read as JSON.
- (NSError *)processJSONResponse;

@end
