//
//  OIDataResource.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"
#import "ODCollection.h"
#import "JSONDateReader.h"

@interface ODResource () <ODCollectionAccessing>
@end

@implementation ODResource {
    id<ODRetrieving> _retrievalInfo;
    ODResourceKind _kind;
    ODEntityType *_entityType;
    __weak id _cachedChildren;
}


@synthesize kind = _kind;
@synthesize retrievalInfo = _retrievalInfo;
@synthesize entityType = _entityType;
@synthesize childrenArray = _cachedChildren;

- (id)dateTimeFormatterV2 {
    static JSONDateReader *shared ;
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

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.retrievalInfo;
}

+ (instancetype)new {
    return [self resourceWithDict:[self resourceDict]];
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

+ (instancetype)resourceWithInfo:(ODRetrievalInfo *)info {
    return [[self alloc] initWithRetrievalInfo:info];
}

+ (instancetype)resourceWithURL:(NSURL *)URL description:(NSString *)description {
    ODRetrievalByURL *info = [ODRetrievalByURL new];
    info.URL = URL;
    info.shortDescription = description;
    return [self resourceWithInfo:info];
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
    return [self.retrievalInfo getFromHierarchy:_cmd];
}

- (NSString *)shortDescription {
    return [self.retrievalInfo getFromHierarchy:_cmd];
}

- (instancetype)autoretrieve {
    [self retrieve];
    return self;
}

- (void)handleOperation:(ODOperation *)operation {
    [self.retrievalInfo handleOperation:operation];
}

@end
