//
//  OCOperation.h
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCOperation : NSOperation

@property id input;
@property (readonly) NSArray *channels;

@property (readonly) NSError *error;

@property (atomic, readonly) BOOL isExecuting;
@property (atomic, readonly) BOOL isFinished;

@end
