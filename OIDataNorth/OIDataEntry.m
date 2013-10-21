//
//  OIDataEntry.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataEntry.h"
#import "OIDataCollection.h"

@implementation OIDataEntry {
    NSDictionary *_keys;
}

- (NSDictionary *)keys {
    return _keys;
}

- (void)setKeys:(id)keys {
    if ([keys isKindOfClass:NSString.class])
        _keys = @{@"" : keys};
    else
        _keys = keys;
}

- (NSString *)relativePath {
    NSString *keyString = _keys[@""];
    if (!keyString) {
        NSMutableArray *keyStrings = [NSMutableArray new];
        for (NSString *property in _keys) {
            [keyStrings addObject:[NSString stringWithFormat:@"%@=%@", property, _keys[property]]];
        }
        keyString = [keyStrings componentsJoinedByString:@"&"];
    }
    return [NSString stringWithFormat:@"%@(%@)"]
}
@end
