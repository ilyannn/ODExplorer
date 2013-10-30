//
//  OIDataResource.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrieveOperation.h"
#import "ODRetrievalInfo.h"

#import "ODResource+Entity.h"
#import "ODResource+Collection.h"

#import "ODResource_Internal.h"

#import "ODRetrieveOperation.h"

@implementation ODResource {
    id _childrenArray;
//    NSMutableDictionary *_localProperties;
//    NSMutableDictionary *_remoteProperties;
//    NSMutableDictionary *_navigationProperties;
}

@synthesize localProperties = _localProperties;
@synthesize remoteProperties = _remoteProperties;
@synthesize navigationProperties = _navigationProperties;

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

+ (instancetype)resourceWithInfo:(id<ODRetrieving>)info {
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

- (instancetype)initWithRetrievalInfo:(ODRetrievalInfo *)info {
    self = [self init];
    if (self) {
        self.retrievalInfo = info;
    }
    return self;
}

- (void)setKind:(ODResourceKind)kind {
    NSAssert(kind != ODResourceKindUnknown, @"You're required to be specific when setting resource kind.");
    if (_kind != kind) {
        NSAssert(_kind == ODResourceKindUnknown, @"Resource kind cannot be changed once set.");
        _kind = kind;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ = [%@](%@)", [super description], [self shortDescription], self.URL];
}

- (NSString *)longDescription {
    switch (self.kind) {
        case ODResourceKindCollection:
            return [NSString stringWithFormat:@"%@; collection = \n%@", [self description], [self.childrenArray description]];
        
        case ODResourceKindEntity:
            return [@[[self description], [self.localProperties description]]
                    componentsJoinedByString: @"entity = \n "];
            
        case ODResourceKindUnknown:
            return [self description];
    }
}

- (NSURL *)URL {
    return [self.retrievalInfo getFromHierarchy:_cmd];
}

- (NSString *)shortDescription {
    return [self.retrievalInfo getFromHierarchy:_cmd];
}

- (void)handleOperation:(ODOperation *)operation {
    [self.retrievalInfo handleOperation:operation];
}

- (id)childrenArray {
    @synchronized(self) {
        if (!_childrenArray && _resourceValue) {
            switch (self.kind) {
                case ODResourceKindEntity:
                    _childrenArray = [self childrenArrayForEntity];
                    break;
                    
                case ODResourceKindCollection:
                    _childrenArray = [self childrenArrayForCollection];
                    break;
                    
                default: ;
            }
        }
        if (!_childrenArray && self.automaticallyRetrieve) {
            self.automaticallyRetrieve = NO;
            [self retrieve];
        }
        return _childrenArray;
    }
}

- (void)setChildrenArray:(id)childrenArray {
    @synchronized(self) {
        _childrenArray = childrenArray;
    }
}

- (instancetype)autoretrieve {
    self.automaticallyRetrieve = YES;
    return self;
}

- (void)retrieve {
    [self handleOperation:[self retrieveOperation]];
}

- (ODRetrieveOperation *)retrieveOperation {
    ODRetrieveOperation *operation = [ODRetrieveOperation operationWithResource:self];
    [operation addOperationStep:^NSError *(ODRetrieveOperation *op) {
        self.kind = op.responseKind;
        switch (op.responseKind) {
            case ODResourceKindEntity:
                return [self parseFromJSONDictionary:op.responseList[0]];
                
            case ODResourceKindCollection:
                return [self parseFromJSONArray:op.responseList];

            default: return nil;
        }
    }];
    return operation;
}


@end


