//
//  ODEntitySet.h
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollection.h"
#import "ODService.h"
#import "ODEntityType.h"

@interface ODEntitySet : ODCollection

+ (instancetype)entitySetWithService:(ODService *)service name:(NSString *)name entityType:(ODEntityType *)entityType;

@end
