//
//  ODEntityType.h
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODEntity;
@protocol ODRetrieving;

@interface ODEntityType : NSObject

- (ODEntity *)entityWithInfo:(id<ODRetrieving>)info;
- (ODEntity *)deserializeEntityFrom:(NSDictionary *)entityDict
                           withInfo:(id<ODRetrieving>)info;

@property NSString *className;

@end
