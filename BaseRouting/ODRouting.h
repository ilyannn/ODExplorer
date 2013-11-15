//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODType;

/// Protocol to retrieve information about a resource within a context.
/// Retrieval protocol doesn't provide a way to modify the information, although
/// individual classes may provide a way to modify their properties.
@protocol ODRouting <NSObject>

- (NSURL *)URL;
- (NSString *)shortDescription;

- (ODType *)metadataType;
- (BOOL)isRootURL;
@end
