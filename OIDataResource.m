//
//  OIDataResource.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataResource.h"

@implementation OIDataResource

- (instancetype)initWithParent:(OIDataResource *)parent {
    if (self = [super init]) {
        self.parent = parent;
    }
    return self;
}

- (NSURL *)URL {
    return [NSURL URLWithString:self.relativePath relativeToURL:self.baseURL];
}

@end
