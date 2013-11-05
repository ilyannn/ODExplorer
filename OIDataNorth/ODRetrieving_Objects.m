//
//  ODRetrievalInfo.m
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrieving_Objects.h"
#import "ODBaseRequestManager.h"

@implementation ODRetrieveBase {
    NSMutableArray *_managers;
}

static ODRetrieveBase *_sharedRootInfo;

+ (ODRetrieveBase *)sharedRoot {
    if (!_sharedRootInfo) {
        _sharedRootInfo = [self new];
        [_sharedRootInfo addManager: [ODBaseRequestManager new]];
    }
    return _sharedRootInfo;
}

+ (void)setSharedRoot:(ODRetrieveBase *)info {
    _sharedRootInfo = info;
}

- (BOOL)isRootURL {
    return NO;
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

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//- (id)getFromHierarchy:(SEL)selector {
//    id value = [self performSelector:selector];
//    if (value) return value;
//    return [self.parent getFromHierarchy:selector];
//}
//#pragma clang diagnostic pop

- (void)handleOperation:(id)operation {
    for (id<ODManaging> manager in [self managers]) {
        if ([manager handleOperation:operation]) return;
    }
    ODRetrieveBase *target = self.parent ? self.parent : [self.class sharedRoot];
    [target handleOperation:operation];
}

- (NSURL *)URL {
    return [self.parent URL];
}

- (NSString *)shortDescription {
    return [self.parent shortDescription];
}

- (ODType *)metadataType {
    return [self.parent metadataType];
}

@end

@implementation ODRetrieveByURL

- (BOOL)isRootURL {
    return !!self.URL && ![self.parent URL];
}

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

#import "ODServiceType.h"

@implementation ODRetrievalOfEntitySet

- (NSString *)relativePath {
    return self.entitySetPath;
}

- (ODType *)metadataType {
    ODType *type = [self.parent metadataType];
    if (![type respondsToSelector:@selector(model)]) {
        return nil;
    }
    ODMetadataModel *model = [type performSelector:@selector(model)];
    return model.entitySets[self.entitySetPath];
}

@end

@implementation ODRetrievalOfProperty

- (NSString *)relativePath {
    return self.propertyName;
}

- (ODType *)metadataType {
    ODType *type = [self.parent metadataType];
    if (![type respondsToSelector:@selector(properties)]) {
        return nil;
    }
    NSDictionary *properties = [type performSelector:@selector(properties)];
    return properties[self.propertyName];
}

//- (NSString *)shortDescription {
//    NSString *typeDesc = [self.metadataType description];
//    return self.metadataType ? [NSString stringWithFormat:@"%@:%@", [super shortDescription], typeDesc]
//                    : [super shortDescription];
//}

@end

@implementation  ODRetrievalByBrackets

- (NSString *)bracketPart {
    return nil;
}

- (NSURL *)URL {
    if (self.knownURL) return self.knownURL;
    NSString *relative = [NSString stringWithFormat:@"%@(%@)", [self.parent relativePath], [self bracketPart]];
    return [[[self.parent URL] URLByDeletingLastPathComponent] URLByAppendingPathComponent:relative];
}


@end

@implementation ODRetrievalByIndex

- (NSString *)bracketPart {
    return [NSString stringWithFormat:@"%lu", (unsigned long)self.index];
}

- (NSString *)shortDescription {
    return [NSString stringWithFormat:@"%@", [self bracketPart]];
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


@implementation ODRouteMetadata

- (ODType *)metadataType {
    return [[ODServiceType alloc] initWithModel:self.metadataModel];
}

@end