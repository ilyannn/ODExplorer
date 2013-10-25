//
//  ODEntityType.h
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODEntity;

@interface ODEntityType : NSObject

- (ODEntity *)createEntity;
- (ODEntity *)deserializeEntityFrom: (NSDictionary *)entityDict;
@property NSString *className;

@end
