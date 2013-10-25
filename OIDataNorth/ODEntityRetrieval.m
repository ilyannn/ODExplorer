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
- (NSURL *)retrievalURL {
    return nil;
}

- (NSString *)shortDescription {
    return @"";
}

@end

@implementation ODEntityRetrievalByIndex

- (NSURL *)retrievalURL {
    ODResource *parent = [self.collection parent];
    NSString *relativePart = [NSString stringWithFormat:@"%@(%lu)", [self.collection name], (unsigned long)self.index];
    return [NSURL URLWithString:relativePart relativeToURL:parent.URL];
}

- (NSString *)shortDescription {
    return [NSString stringWithFormat:@"%lu", (unsigned long)self.index];
}

@end

@implementation ODEntityRetrievalByProperty

- (NSURL *)retrievalURL {
    return [self.fromEntity.URL URLByAppendingPathComponent:self.propertyName];
}

- (NSString *)shortDescription {
    return self.propertyName;
}

@end

@implementation ODEntityRetrievalByKeys


@end

@implementation ODEntityRetrievalByURL
// don't need anything here
@end
