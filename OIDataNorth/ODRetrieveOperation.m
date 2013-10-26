//
//  ODRetrieveOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrieveOperation.h"
#import "ODEntity.h"
#import "ODOperationError.h"

@implementation ODRetrieveOperation

+ (instancetype)operationWithResource:(ODEntity *)entity {
    return [super operationWithResource:entity];
}

- (NSError *)processJSONResponse:(id)response {
    ODAssert(response, nil);
    ODAssertClass(response, NSDictionary);
    
    [self.resource updateFromDict:response];
    return nil;
}

@end
