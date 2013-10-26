//
//  ODPlainOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPlainOperation.h"
#import "ODOperationError.h"

@implementation ODPlainOperation

- (NSError *)processResponse:(ODOperationResponse *)response {
    NSString *stringResponse = [[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding];
    
    if (!stringResponse)
        return [ODOperationError errorWithCode:kODOperationErrorBadEncoding
                                      userInfo:@{@"data":response.data}];
    
    return [self processPlainResponse: stringResponse];
}

- (NSError *)processPlainResponse:(NSString *)responseString ODErrorAbstractOp;


@end
