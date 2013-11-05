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

@property NSString *associationName;
@property NSString *roleName;
@property (readonly) id key;

@property NSString *multiplicity;
@property (readonly, getter = isRequired) BOOL required;
@property (readonly, getter = isCollection) BOOL collection;

@property NSString *typeName;

@end
