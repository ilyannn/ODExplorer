//
//  OIDataResource.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODManagingProtocols.h"

#import "ODRetrievalInfo.h"
#import "ODEntityType.h"

typedef NS_ENUM (NSInteger, ODResourceKind) {
    ODResourceKindUnknown = 0,
    ODResourceKindEntity,
    ODResourceKindCollection
};

@class ODResource, ODCollection, ODEntity, ODEntitySet;

@protocol ODResourceAccessing <NSObject>

// The fundamental dichotonomy between resources; a resource either responds with a dictionary or
// with an array when retrieved. Here property is an entity with a standard type and service is
// a collection, albeit non-standard in the sense that it contains collections.
@property (nonatomic) ODResourceKind kind;
@property (readonly, nonatomic) NSURL *URL;
- (NSString *)shortDescription;
@property (nonatomic) ODRetrievalInfo *retrievalInfo;
@property (nonatomic) ODEntityType *entityType;
@end


// This class implements all of functionality for resources, but declares only the base part.
@interface ODResource : NSObject <ODResourceAccessing>


@property (nonatomic) ODResource *parent;
//@property (nonatomic) NSMutableDictionary *strongChildren;

@property (nonatomic) id <ODFaultManaging> readManager;
@property (nonatomic) id <ODChangeManaging> changeManager;

@end
