//
//  OIDataResource.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"

@implementation ODResource

- (NSURL *)URL {
    return nil; // we're abstract
}

- (id<ODFaultManaging>)readManager {
    return _readManager ? _readManager : [self parent].readManager;
}

- (id<ODChangeManaging>)changeManager {
    return _changeManager ? _changeManager : [self parent].changeManager;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ -> %@", [super description], self.URL];
}

@end
