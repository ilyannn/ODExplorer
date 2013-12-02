//
//  OCRequestSaverChannel.h
//  ODExplorerLib
//
//  Created by ilya on 12/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCChannel.h"

@interface OCHTTPResponseAnalyzerChannel : OCChannel
@property (readonly) NSArray *responses;
@end
