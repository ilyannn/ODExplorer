//
//  ODRetrievalInfo.m
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrievalInfo.h"
#import "ODBaseRequestManager.h"

@implementation ODRetrievalInfo {
    NSMutableArray *_managers;
}

+ (ODRetrievalInfo *)sharedRoot {
    static ODRetrievalInfo *_sharedRootInfo;
    if (!_sharedRootInfo) {
        _sharedRootInfo = [self new];
        [_sharedRootInfo addManager: [ODBaseRequestManager new]];
    }
    return _sharedRootInfo;
}

- (NSArray *)managers {
    return [_managers copy];
}

- (void)addManager:(id)manager {
    [_managers insertObject:manager atIndex:0];
}

- (id)init {
    self = [super init];
    if (self) {
        _managers = [NSMutableArray new];
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (id)getFromHierarchy:(SEL)selector {
    id value = [self performSelector:selector];
    if (value) return value;
    return [self.parent getFromHierarchy:selector];
}
#pragma clang diagnostic pop

- (void)handleOperation:(id)operation {
    for (id<ODManaging> manager in [self managers]) {
        if ([manager handleOperation:operation]) return;
    }
    ODRetrievalInfo *target = self.parent ? self.parent : [self.class sharedRoot];
    [target handleOperation:operation];
}

- (NSURL *)URL {
    return nil; // we're abstract
}

- (NSString *)shortDescription {
    return nil;
}

@end

@implementation ODRetrievalByURL
// auto synthesized
@end

@implementation ODRetrievalByPath

- (NSURL *)URL {
    return [[self.parent URL] URLByAppendingPathComponent:[self relativePath]];
}

- (NSString *)relativePath {
    return nil;
}

- (NSString *)shortDescription {
    return [self relativePath];
}

@end

@implementation ODRetrievalOfEntitySet

- (NSString *)relativePath {
    return self.entitySetPath;
}

@end

@implementation ODRetrievalOfProperty

- (NSString *)relativePath {
    return self.propertyName;
}

@end

@implementation  ODRetrievalByBrackets

- (NSString *)bracketPart {
    return nil;
}

- (NSURL *)URL {
    NSString *relative = [NSString stringWithFormat:@"%@(%@)", [self.parent relativePath], [self bracketPart]];
    return [[self.parent.parent URL] URLByAppendingPathComponent:relative];
}


@end

@implementation ODRetrievalByIndex

- (NSString *)bracketPart {
    return [NSString stringWithFormat:@"%lu", (unsigned long)self.index];
}

- (NSString *)shortDescription {
    return [NSString stringWithFormat:@"#%@", [self bracketPart]];
}

@end

@implementation ODRetrievalByKeys

- (NSDictionary *)keys {
    return nil;
}

- (NSString *)bracketPart {
    NSDictionary *keys = [self keys];
    id value = keys[@""];
    if (value) return [value description];
    
    NSMutableArray *list = [NSMutableArray new];
    [keys enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        [list addObject:[NSString stringWithFormat:@"%@=%@", key, [obj description]]];
    }];
    return [list componentsJoinedByString:@"&"];
}

- (NSString *)shortDescription {
    return [self bracketPart];
}

@end
