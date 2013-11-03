//
//  ODAssociationEnd.m
//  OIDataNorth
//
//  Created by ilya on 11/4/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODAssociationEnd.h"

@implementation ODAssociationEnd

+ (id)keyForAssociation:(NSString *)associationName role:(NSString *)roleName {
    return @[associationName, roleName];
}

- (id)key {
    return [ODAssociationEnd keyForAssociation:self.associationName role:self.roleName];
}

@end
