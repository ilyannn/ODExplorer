//
//  OIDataResource.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"
#import "ODCollection.h"

@interface ODResource () <ODCollectionAccessing>

@end

@implementation ODResource {
    ODRetrievalInfo *_retrievalInfo;
    ODResourceKind _kind;
    ODEntityType *_entityType;
    __weak id _cachedChildren;
}


@synthesize kind = _kind;
@synthesize retrievalInfo = _retrievalInfo;
@synthesize entityType = _entityType;
@synthesize childrenArray = _cachedChildren;


- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.retrievalInfo;
}

+ (instancetype)unique {
    return [self uniqueWithDict:[self resourceDict]];
}

+ (instancetype)uniqueWithDict:(NSDictionary *)dict {
    if (!dict) return nil;
    
    static NSMapTable *uniques;
    if (!uniques) {
        uniques = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory
                                        valueOptions:NSMapTableWeakMemory ];
    }

    id value = [uniques objectForKey:dict];
    if (!value) {
        value = [self resourceWithDict:dict];
        [uniques setObject:value forKey:dict];
    }
    
    return value;
}

+ (NSDictionary *)resourceDict {
    return nil;
}

+ (instancetype)resourceWithURL:(NSURL *)URL description:(NSString *)description {
    ODRetrievalByURL *info = [ODRetrievalByURL new];
    info.URL = URL;
    info.shortDescription = description;
    
    return [[self alloc] initWithRetrievalInfo:info];
}

+ (instancetype)resourceWithDict:(id)dict {
    return [self resourceWithURL:[NSURL URLWithString:dict[@"uri"]] description:dict[@"name"]];
}

+ (instancetype)resourceWithURLString:(NSString *)URLString {
    return [self resourceWithURL:[NSURL URLWithString:URLString] description:nil];
}

// -(id)init is still the designated initializer

- (instancetype)initWithRetrievalInfo:(ODRetrievalInfo *)info {
    self = [self init];
    if (self) {
        self.retrievalInfo = info;
    }
    return self;
}

- (void)setKind:(ODResourceKind)kind {
    NSAssert(kind != ODResourceKindUnknown, @"You're required to be specific when setting resource kind.");
    NSAssert(self.kind == ODResourceKindUnknown, @"Resource kind cannot be set more then one time.");
    _kind = kind;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ = [%@](%@)", [super description], [self shortDescription], self.URL];
}

- (NSString *)longDescription {
    return [NSString stringWithFormat:@"%@; kind = %i; %@", [self description], self.kind, [self.childrenArray description]];
}

- (NSURL *)URL {
    return [self.retrievalInfo performHierarchically:_cmd];
}

- (NSString *)shortDescription {
    return [self.retrievalInfo performHierarchically:_cmd];
}

- (id <ODFaultManaging> )readManager {
    return [self.retrievalInfo performHierarchically:_cmd];
}

- (id <ODChangeManaging> )changeManager {
    return [self.retrievalInfo performHierarchically:_cmd];
}

- (instancetype)autoretrieve {
    [self retrieve];
    return self;
}

@end
