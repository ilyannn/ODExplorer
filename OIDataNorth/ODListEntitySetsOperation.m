//
//  ODListEntitySetsOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODListEntitySetsOperation.h"
#import "ODService.h"
#import "ODEntity.h"

#import "ODOperationError+Parsing.h"
#import "ODRetrievalInfo.h"

#import "ODResource_Internal.h"

@implementation ODListEntitySetsOperation

- (NSError *)processJSONResponseV3:(id)responseJSON {
    NSArray *responseArray = responseJSON;

    if ([responseArray isKindOfClass:[NSDictionary class]] && responseJSON[@"d"]) {
        responseArray = responseJSON[@"d"];
    }


    if ([responseArray isKindOfClass:[NSDictionary class]] && responseJSON[@"data"]) {
        responseArray = responseJSON[@"data"];
    }

    ODAssertODataClass(responseArray, NSArray);

    NSMutableDictionary *entitySets = [NSMutableDictionary new];
    [responseArray enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *name;
        NSString *uri;

        if ([obj isKindOfClass:NSDictionary.class]) {
            name = obj[@"name"];
            uri = obj[@"url"];
        } else if ([obj isKindOfClass:NSString.class]) {
            name = obj;
            uri = obj;
        } else {
            name = nil;
            uri = nil;
        }
        
        if ([name isKindOfClass:NSString.class] && [uri isKindOfClass:NSString.class]) {
            ODRetrievalOfEntitySet * info = [ODRetrievalOfEntitySet new];
            info.parent = self.retrievalInfo;
            info.shortDescription = name;
            info.entitySetPath = name;
            
            ODCollection *entitySet = [ODCollection new];
            entitySet.retrievalInfo = info;
            entitySet.entityType = [ODEntity entityType];

            entitySets[name] = entitySet;
        }
    }];
    
    
    return nil;
}

@end
