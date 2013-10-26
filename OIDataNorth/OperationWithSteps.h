//
//  ODOperationWithSteps.h
//  OIDataNorth
//
//  Created by ilya on 10/27/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@interface OperationWithSteps : NSOperation

// Adds an operation. This takes a parameter self, so you don't need to capture any variables.
- (void)addOperationStep:(NSError * (^)(id operation))step;
- (void)cleanOperationSteps;

@property NSError *error;

// Redefine this instead of -main.
- (NSArray *)steps;

@end
