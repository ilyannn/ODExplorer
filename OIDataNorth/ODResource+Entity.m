//
//  ODResource+Entity.m
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource+Entity.h"
#import "ODResource_Internal.h"

#import "ODRetrievalInfo.h"

#import "JSONDateReader.h"
#import "NSData+Base64.h"

#import "ODOperationError+Parsing.h"

#define ODEntityAssert NSAssert(self.kind == ODResourceKindEntity, \
@"This should be called only for entities!");

@implementation ODResource(Entity)

- (id)dateTimeFormatterV2 {
    static id shared ;
    if (!shared) {
        shared = [JSONDateReader new];
    }
    return shared;
}

- (id)dateTimeFormatterV3 {
    static NSDateFormatter *shared ;
    if (!shared) {
        shared = [NSDateFormatter new];
        shared.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    }
    return shared;
}

- (NSArray *)childrenArrayForEntity { ODEntityAssert
    
    NSMutableArray *keys = [[self.localProperties allKeys] mutableCopy];
    [keys sortUsingComparator:
            ^NSComparisonResult(NSString *obj1, NSString * obj2) {
                return [obj1 localizedCaseInsensitiveCompare:obj2];
            }];
    for (NSUInteger index = 0; index < keys.count; index++) {
        keys[index] = [self propertyForKey:keys[index]];
    }
    
    return [keys copy];
}

- (ODResource *)propertyForKey:(NSString *)key {
    ODRetrievalOfProperty *info = [ODRetrievalOfProperty new];
    info.propertyName = key;
    info.parent = self.retrievalInfo;

    ODResource *property =  [ODResource resourceWithInfo:info];
    property.resourceValue = self.localProperties[key];
    return property;
}

- (NSError *)parseFromJSONDictionary:(NSDictionary *)dict{ ODEntityAssert
    ODAssertODataClass(dict, NSDictionary);
    
    self.remoteProperties = [NSMutableDictionary new];
    self.navigationProperties = [NSMutableDictionary new];


    [dict enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        
        if ([obj isKindOfClass:NSDictionary.class]) {
            ODRetrievalOfProperty *retrieval = [ODRetrievalOfProperty new];
            retrieval.parent = self.retrievalInfo;
            retrieval.propertyName = key;
            
            /*           ODEntity *entity = [[ODEntity alloc] initFromDict:obj];
             entity.retrievalInfo = retrieval;
             self.navigationProperties[key] = entity;
             */
        } else if ([obj isKindOfClass:[NSNull class]]) {
            // "convert" to nil
        } else if ([obj isKindOfClass:[NSString class]]) {
            // Is this a date?
            if ([obj length] < 1000) {
                id value = nil;
                if (!!(value = [self.dateTimeFormatterV2 dateFromString:obj])
                    || !!(value = [self.dateTimeFormatterV3 dateFromString:obj])
                    ||(!!(value = [NSURL URLWithString:obj]) && !!([(NSURL *)value scheme].length))
                    ) {
                    obj = value;
                }
            } else {
                NSData *data  = [NSData dataFromBase64String:obj];
                if (data) {
                    UIImage *image = [UIImage imageWithData:data];
                    obj = image ? image : data;
                }
            }
            self.remoteProperties[key] = obj;
        } else {
            self.remoteProperties[key] = obj;
        }
        
    }];
    
    self.localProperties = [self.remoteProperties mutableCopy];
    return nil;
}

- (NSMutableDictionary *)localProperties { ODEntityAssert
    return self.resourceValue;
}

- (void)setLocalProperties:(NSMutableDictionary *)localProperties { ODEntityAssert
    self.resourceValue = localProperties;
}

@end
