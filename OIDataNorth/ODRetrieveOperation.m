//
//  ODRetrieveOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrieveOperation.h"
#import "ODEntity.h"

#import "ODOperationError+Parsing.h"

@implementation ODRetrieveOperation

+ (instancetype)operationWithResource:(ODEntity *)entity {
    return [super operationWithResource:entity];
}

- (NSError *)processJSONResponse:(id)response {
    ODAssertOData(response, nil);
    ODAssertODataClass(response, NSDictionary);
    
    [self.resource updateFromDict:response];
    return nil;
}

@end
