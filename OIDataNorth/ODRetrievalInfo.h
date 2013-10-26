//
//  ODRetrievalInfo.h
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@protocol ODFaultManaging, ODChangeManaging;

@interface ODRetrievalInfo : NSObject

@property ODRetrievalInfo *parent;
- (id)getFromHierarhy:(SEL)selector;

@property (nonatomic) id <ODFaultManaging> readManager;
@property (nonatomic) id <ODChangeManaging> changeManager;

- (NSURL *)retrievalURL;
- (NSString *)shortDescription;
@end
