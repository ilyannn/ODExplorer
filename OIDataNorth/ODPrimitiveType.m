//
//  ODEntityType.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"
#import "ODEntity.h"
#import "ODCollection.h"
#import "ODResource+Entity.h"
#import "ODResource+Collection.h"

#import <objc/runtime.h>

@implementation ODPrimitiveType

- (BOOL)isPrimitive {
    return YES;
}

- (id)valueForJSONString:(NSString *)obj {
    return nil;
}

- (id)valueForJSONNumber:(NSString *)obj {
    return nil;
}

- (id)valueForJSONObject:(id)obj {
    if ([obj isKindOfClass:[NSNull class]]) {
        // "convert" to nil
        return nil;
    } else if ([obj isKindOfClass:[NSString class]]) {
        return [self valueForJSONString:obj];
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return [self valueForJSONNumber:obj];
    } else {
        NSLog(@"Unknown JSON type: %@. Seriously?", NSStringFromClass([obj class]));
        return nil;
    }
}

- (ODEntity *)entityWithInfo:(id)info {
    ODEntity * entity = [NSClassFromString(self.className) resourceWithInfo:info];
    entity.entityType = self;
    return entity;
}

- (ODEntity *)deserializeEntityFrom:(NSDictionary *)entityDict
                         withInfo:(id<ODRetrieving>)info {
    ODEntity *entity = [self entityWithInfo:info];
    entity.entityType = self;
    return [entity parseFromJSONDictionary:entityDict] ? nil : entity;
}

- (ODCollection *)deserializeCollectionFromArray:(NSArray *)collectionArray
                           withInfo:(id<ODRetrieving>)info {
    ODCollection *collection = [ODCollection resourceWithInfo:info];
    collection.entityType = self;
    return [collection parseFromJSONArray:collectionArray] ? nil : collection;
}

- (NSString *)className {
    char x[1000];
    method_getReturnType(class_getInstanceMethod([self class], @selector(valueForJSONString:)),
                         x, sizeof(x));
    
    return @"xxx";
}

@end
