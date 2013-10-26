//
//  ODEntityRetrieval.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntityRetrieval.h"
#import "ODCollection.h"
#import "ODEntity.h"

@implementation ODEntityRetrieval
- (NSURL *)URL {
    return nil;
}

- (NSString *)shortDescription {
    return @"";
}

@end

@implementation ODEntityRetrievalByIndex

- (NSString *)shortDescription {
    return [NSString stringWithFormat:@"%lu", (unsigned long)self.index];
}


@end



@implementation ODEntityRetrievalByKeys


@end

