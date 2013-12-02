//
//  OCHTTPRequestChannelOperation.h
//  ODExplorerLib
//
//  Created by ilya on 12/1/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "AFURLConnectionOperation.h"

@interface OCHTTPRequestChannelOperation : AFURLConnectionOperation
@property (atomic, readwrite, copy) void (^sendBlock)(id data);
@property (atomic, readwrite, copy) void (^errorBlock)(NSError *error);
@end
