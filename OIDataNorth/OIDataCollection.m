//
//  OIDataCollection.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataCollection.h"
#import "OIDataEntry.h"

@implementation OIDataCollection

- (NSString *)relativePath {
    return [NSString stringWithFormat:@"/%@/", self.name];
}

- (OIDataEntry *)objectForKey:(id)keys {
    OIDataEntry *entry = [[OIDataEntry alloc] initWithParent:self];
    entry.keys = @{@"" : objectKey};
    return entry;
}

@end
