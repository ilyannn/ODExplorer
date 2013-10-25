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
    ODResourceKind _kind;
    ODRetrievalInfo *_retrievalInfo;
    ODEntityType *_entityType;
}

@synthesize kind = _kind;
@synthesize retrievalInfo = _retrievalInfo;
@synthesize entityType = _entityType;

- (void)setKind:(ODResourceKind)kind {
    NSAssert(kind != ODResourceKindUnknown, @"You're required to be specific when setting resource kind.");
    NSAssert(self.kind == ODResourceKindUnknown, @"Resource kind cannot be set more then one time.");
    _kind = kind;
}

- (NSURL *)URL {
    return nil; // we're abstract
}

- (id <ODFaultManaging> )readManager {
    return _readManager ? _readManager : [self parent].readManager;
}

- (id <ODChangeManaging> )changeManager {
    return _changeManager ? _changeManager : [self parent].changeManager;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ -> %@", [super description], self.URL];
}

@end
