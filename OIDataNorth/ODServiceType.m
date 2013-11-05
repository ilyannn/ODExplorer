//
//  ODServiceType.m
//  OIDataNorth
//
//  Created by ilya on 11/5/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODServiceType.h"

@implementation ODServiceType

- (instancetype)initWithModel:(ODMetadataModel *)model {
    if (self = [super initWithElementType:nil]) {
        _model = model;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Service[%@]", self.model.schemaNamespace];
}

@end
