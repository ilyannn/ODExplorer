//
//  ODResource+Entity.m
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource+Entity.h"
#import "ODResource_Internal.h"

#import "ODRetrieving_Objects.h"

#import "NSData+Base64.h"

#import "ODOperationError+Parsing.h"

#import "ODPrimitiveType.h"
#import "ODTypeLibrary.h"

#define ODEntityAssert NSAssert(self.kind == ODResourceKindEntity, \
@"This should be called only for entities!");

@implementation ODResource(Entity)


- (NSArray *)childrenArrayForEntity { ODEntityAssert
    
    NSMutableArray *keys = [[self.localProperties allKeys] mutableCopy];
    [keys sortUsingComparator:
            ^NSComparisonResult(NSString *obj1, NSString * obj2) {
                return [obj1 localizedCaseInsensitiveCompare:obj2];
            }];
    for (NSUInteger index = 0; index < keys.count; index++) {
        keys[index] = [self propertyForKey:keys[index]];
    }
    
    [keys addObjectsFromArray:[self.navigationProperties allValues]];
    return [keys copy];
}

- (ODResource *)propertyForKey:(NSString *)key {
    ODRetrievalOfProperty *info = [ODRetrievalOfProperty new];
    info.propertyName = key;
    info.parent = self.retrievalInfo;

    ODResource *property =  [ODResource resourceWithInfo:info];
    property.resourceValue = self.localProperties[key];
    property.childrenArray = @[property];
    property.type = [[ODTypeLibrary shared] uniqueTypeFor:@"String"];
    return property;
}

- (NSError *)parseFromJSONDictionary:(NSDictionary *)dict{ ODEntityAssert
    ODAssertODataClass(dict, NSDictionary);
    
    self.remoteProperties = [NSMutableDictionary new];
    self.navigationProperties = [NSMutableDictionary new];

    [dict enumerateKeysAndObjectsUsingBlock: ^(NSString *key, id obj, BOOL *stop) {

        // ID annotation
        if ([key isEqualToString:@"odata.id"]) {
            if ([obj isKindOfClass:[NSString class]]) {
                ODRetrieveByURL *info = [ODRetrieveByURL new];
                info.parent = self.retrievalInfo;
                info.URL = [NSURL URLWithString:obj relativeToURL:[self URL]];
                if (info.URL) self.retrievalInfo = info;
            }
            return;
        }

        // Type annotation
        if ([key isEqualToString:@"odata.type"]) {
            if ([obj isKindOfClass:[NSString class]]) {
                self.type = [[ODTypeLibrary shared] uniqueTypeFor:obj];
            }
            return;
        }
        
        // Navigation properties
        if ([key rangeOfString:@"@"].location != NSNotFound) {
            NSArray *components = [key componentsSeparatedByString:@"@"];
            if (components.count == 2 && [components[1] isEqualToString:@"odata.navigationLinkUrl"]) {
                ODRetrievalOfProperty *info = [ODRetrievalOfProperty new];
                info.parent = self.retrievalInfo;
                info.propertyName = components[0];
                self.navigationProperties[components[0]] = [ODResource resourceWithInfo:info];
                return;
            } if (components.count == 2 && [components[1] isEqualToString:@"odata.type"]) {
                return;
            } else {
                NSLog(@"Unknown annotation: %@", key);
            }
        }
        
        if ([obj isKindOfClass:NSDictionary.class]) {
            ODRetrievalOfProperty *retrieval = [ODRetrievalOfProperty new];
            retrieval.parent = self.retrievalInfo;
            retrieval.propertyName = key;
            
            /* ODEntity *entity = [[ODEntity alloc] initFromDict:obj];
            entity.retrievalInfo = retrieval;
             self.navigationProperties[key] = entity;
             */
            return;
        }
        
        // Primitive properties
        NSString *typeName = dict[[NSString stringWithFormat:@"%@@odata.type", key]];
        ODType *type = [[ODTypeLibrary shared] uniqueTypeFor:typeName];
        if (type && [type respondsToSelector:@selector(valueForJSONObject:)]) {
            obj = [type performSelector:@selector(valueForJSONObject:) withObject:obj];
        }
        if (obj) self.remoteProperties[key] = obj;

//                    ||(!!(value = [NSURL URLWithString:obj]) && !!([(NSURL *)value scheme].length))
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

- (void)dropEntityChildrenRecursively:(BOOL)recursively {
    self.childrenArray = nil;
    if (recursively) {
        [self.navigationProperties enumerateKeysAndObjectsUsingBlock:^(NSString *key, id<ODResource> obj, BOOL *stop) {
            [obj dropChildrenRecursively:YES];
        }];
    }
}

@end
