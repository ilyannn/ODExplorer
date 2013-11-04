//
//  ODRetrieving_Protocol.h
//  OIDataNorth
//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODMetadataOperation, ODMetadataModel;
@class ODType;

/// Protocol to retrieve information about a resource within a context.
/// Retrieval protocol doesn't provide a way to modify the information, although
/// individual classes may provide a way to modify their properties.
@protocol ODRetrieving <NSObject>

- (NSURL *)URL;
- (NSString *)shortDescription;

- (BOOL)isRootURL;

- (void)handleOperation: (ODOperation *)operation;

- (ODType *)metadataType;


- (ODMetadataOperation *)metadataOperation;
- (void)retrieveMetadata;

@end
