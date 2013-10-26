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

- (void)setKind:(ODResourceKind)kind {
    NSAssert(kind != ODResourceKindUnknown, @"You're required to be specific when setting resource kind.");
    NSAssert(self.kind == ODResourceKindUnknown, @"Resource kind cannot be set more then one time.");
    _kind = kind;
}

- (NSURL *)URL {
    return nil; // we're abstract
}

- (NSString *)shortDescription {
    return [self.retrievalInfo shortDescription];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ = [%@](%@)", [super description], [self shortDescription], self.URL];
}

- (NSString *)longDescription {
    return [NSString stringWithFormat:@"%@; kind = %i; %@", [self description], self.kind, [self.childrenArray description]];
}


- (id <ODFaultManaging> )readManager {
    return [self.retrievalInfo getFromHierarhy:_cmd];
}

- (id <ODChangeManaging> )changeManager {
    return [self.retrievalInfo getFromHierarhy:_cmd];
}


@end
