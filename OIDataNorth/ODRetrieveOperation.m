//
//  ODRetrieveOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrieveOperation.h"
#import "ODEntity.h"
#import "ODCollection.h"

#import "ODOperationError+Parsing.h"

@implementation ODRetrieveOperation

+ (NSError *)errorForKind:(ODResourceKind)kind {
    return nil;
}

- (NSError *)processJSONResponseV3 {
    id response = self.JSONResponse;
    ODAssertOData(response, @{});
    ODAssertODataClass(response, NSDictionary);

    //    if ([responseArray isKindOfClass:[NSDictionary class]] && [(NSDictionary *)responseArray objectForKey:@"EntitySets"]) {
    //        responseArray = [(NSDictionary *)responseArray objectForKey:@"EntitySets"];
    //    }
    
    self.indeterminateCount = !!response[@"odata.nextLink"];

    if (response[@"value"] && [response[@"value"] isKindOfClass:[NSArray class]]) {
        self.responseKind = ODResourceKindCollection;
        response = response[@"value"];
        ODAssertODataClass(response, NSArray);
        self.responseList = response;
    } else {
        self.responseKind = ODResourceKindEntity;
        ODAssertODataClass(response, NSDictionary);
        self.responseList = @[response];
    }

    return nil;
}

@end
