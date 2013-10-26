//
//  ODRetrievalInfo.m
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrievalInfo.h"
#import "ODManagingProtocols.h"
#import "ODBaseRequestManager.h"

@implementation ODRetrievalInfo

+ (ODRetrievalInfo *)sharedRoot {
    static ODRetrievalInfo *_sharedRootInfo;
    if (!_sharedRootInfo) {
        ODBaseRequestManager *commonManager = [ODBaseRequestManager new];
        _sharedRootInfo = [self new];
        _sharedRootInfo.readManager = commonManager;
        _sharedRootInfo.changeManager = commonManager;
    }
    return _sharedRootInfo;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (id)performHierarchically:(SEL)selector {
    for (ODRetrievalInfo *info = self; info; info = info.parent) {
        id value = [info performSelector:selector];
        if (value) return value;
    }
    return [[self.class sharedRoot] performSelector:selector];
}

#pragma clang diagnostic pop

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

- (NSString *)shortDescription {
    return [self bracketPart];
}

@end

@implementation ODRetrievalByIndex

- (NSString *)bracketPart {
    return [NSString stringWithFormat:@"%lu", (unsigned long)self.index];
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

@end
