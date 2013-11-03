//
//  ODType.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODEntity, ODCollection;
@protocol ODRetrieving;

@interface ODType : NSObject

@property (readonly) NSString *name;
@property (readonly, getter = isPrimitive) BOOL primitive;

- (instancetype)initWithName:(NSString *)name;

/*
- (ODEntity *)deserializeEntityFrom:(NSDictionary *)entityDict
                           withInfo:(id<ODRetrieving>)info;
- (ODCollection *)deserializeCollectionFromArray:(NSArray *)collectionArray
                                        withInfo:(id<ODRetrieving>)info;

*/

@end
