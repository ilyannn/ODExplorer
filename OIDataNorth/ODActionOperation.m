//
//  ODActionOperaion.m
//  OIDataNorth
//
//  Created by ilya on 10/23/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODActionOperation.h"
#import "ODEntity.h"

#import "ODOperationError+Parsing.h"

NSString *const ODHTTPVerbPost = @"POST";

@implementation ODActionOperation

+ (instancetype)operationWithResource:(ODEntity *)entity {
    return [super operationWithResource:entity];
}

- (NSString *)method {
    return ODHTTPVerbPost;
}

- (NSURL *)URL {
    return [[super URL] URLByAppendingPathComponent:self.actionName];
}

- (NSError *)processJSONResponse:(id)responseJSON {
    return nil;
}

- (NSError *)validate {
    ODAssertOperation(self.resource.kind != ODResourceKindCollection, @"You can't perform action on a collection.");
    return nil;
}

@end
