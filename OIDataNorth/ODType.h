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

- (instancetype)initWithName:(NSString *)name;
@property (readonly) NSString *name;

@property (readonly, getter = isCollection) BOOL collection;
@property (readonly, getter = isPrimitive) BOOL primitive;


/*
- (ODEntity *)deserializeEntityFrom:(NSDictionary *)entityDict
                           withInfo:(id<ODRetrieving>)info;
- (ODCollection *)deserializeCollectionFromArray:(NSArray *)collectionArray
                                        withInfo:(id<ODRetrieving>)info;

*/

@end
