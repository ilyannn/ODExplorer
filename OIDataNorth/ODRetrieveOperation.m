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

- (NSError *)processJSONResponseVerbose {
    ODAssertODataClass(self.responseJSON, NSDictionary);
    id response = self.responseJSON[@"d"];
    ODAssertOData(response, @{NSLocalizedFailureReasonErrorKey : @"The response should be wrapped in 'd'."});

    if ([response isKindOfClass:[NSArray class]]) { // version 1
        self.responseKind = ODResourceKindCollection;
        self.responseList = response;
        return nil;
    }

    ODAssertODataClass(response, NSDictionary); // version 2 or 3
    id values = response[@"results"];

    if (values) { // version 2
        ODAssertODataClass(values, NSArray);
        self.responseKind = ODResourceKindCollection;
        self.responseList = values;
        self.indeterminateCount = !!response[@"__next"];
    } else if ((values = response[@"EntitySets"])) { // version 2
        ODAssertODataClass(values, NSArray);
        self.responseKind = ODResourceKindCollection;
        self.responseList = values;
        self.serviceDocument = YES;
    } else {
        ODAssertODataClass(response, NSDictionary);
        self.responseKind = ODResourceKindEntity;
        self.responseList = @[response];
    }
    
    return nil;
}


- (NSError *)processJSONResponseLight {
    ODAssertODataClass(self.responseJSON, NSDictionary);


    //    if ([responseArray isKindOfClass:[NSDictionary class]] && [(NSDictionary *)responseArray objectForKey:@"EntitySets"]) {
    //        responseArray = [(NSDictionary *)responseArray objectForKey:@"EntitySets"];
    //    }
    
    id response = self.responseJSON;
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
