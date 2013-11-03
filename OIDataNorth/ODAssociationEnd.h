//
//  ODAssociationEnd.h
//  OIDataNorth
//
//  Created by ilya on 11/4/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ODAssociationEnd : NSObject
+ (id)keyForAssociation:(NSString *)associationName role:(NSString *)roleName;

@property (readonly) id key;
@property NSString *associationName;
@property NSString *roleName;
@property NSString *typeName;
@property NSString *multiplicity;
@end
