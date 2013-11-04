//
//  ODRetrieving.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODMetadataOperation, ODMetadataModel;
@class ODType;

/// Protocol to retrieve information about a resource within a context.
/// Retrieval infomation is organized into hierarchy.
@protocol ODRetrieving <NSObject>

- (id<ODRetrieving>)parent;
- (id)getFromHierarchy:(SEL)selector;

- (NSURL *)URL;
- (BOOL)isRootURL;
- (NSString *)shortDescription;

- (void)handleOperation: (ODOperation *)operation;

- (ODType *)metadataType;
- (ODMetadataModel *)metadataModel;
- (ODMetadataOperation *)metadataOperation;
- (void)retrieveMetadata;

@end
