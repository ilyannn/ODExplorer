//
//  ODListEntitySetsOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODListEntitySetsOperation.h"
#import "ODService.h"
#import "ODEntitySet.h"
#import "ODEntity.h"

@implementation ODListEntitySetsOperation

+ (instancetype)operationWithResource:(ODService *)service {
    return [super operationWithResource:service];
}

- (void)processJSONResponse:(id)responseJSON {
    NSArray *responseArray = responseJSON;
    if ([responseJSON isKindOfClass:[NSDictionary class]]) {
        responseArray = responseJSON[@"value"];
    }
    
    if ([responseArray isKindOfClass:NSArray.class]) {
        NSMutableDictionary *entitySets = [NSMutableDictionary new];
        [responseArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:NSDictionary.class]) {
                NSString *name = obj[@"name"];
                NSString *uri = obj[@"url"];
                if ([name isKindOfClass:NSString.class] && [uri isKindOfClass:NSString.class]) {
                     entitySets[name] =[ODEntitySet entitySetWithService:self.resource
                                                                    name:uri
                                                              entityType:ODEntity.entityType];
                }
            }
        }];
        self.resource.entitySets = entitySets;
    }
}

@end
