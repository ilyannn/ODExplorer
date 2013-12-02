//
//  OCHTTPRequestChannelOperation.h
//  ODExplorerLib
//
//  Created by ilya on 12/1/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "AFURLConnectionOperation.h"

@interface OCURLRequestChannelOperation : AFURLConnectionOperation
@property (weak) void (^sendBlock)(id data, BOOL error);
@end
