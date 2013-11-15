//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrieving_Objects.h"
#import "ODBaseRequestManager.h"

@implementation ODRetrieveBase

- (BOOL)isRootURL {
    return NO;
}

- (NSURL *)URL {
    return [self.parentRoute URL];
}

- (NSString *)shortDescription {
    return [self.parentRoute shortDescription];
}

- (ODType *)metadataType {
    return [self.parentRoute metadataType];
}

@end

@implementation ODRetrieveByURL

- (BOOL)isRootURL {
    return !!self.URL && ![self.parentRoute URL];
}

@end

@implementation ODRetrievalByPath

- (NSURL *)URL {
    return [[self.parentRoute URL] URLByAppendingPathComponent:[self relativePath]];
}

- (NSString *)relativePath {
    return nil;
}

- (NSString *)shortDescription {
    return [self relativePath];
}

@end

#import "ODServiceType.h"

@implementation ODRetrievalOfEntitySet

- (NSString *)relativePath {
    return self.entitySetPath;
}

- (ODType *)metadataType {
    ODType *type = [self.parentRoute metadataType];
    if (![type respondsToSelector:@selector(model)]) {
        return nil;
    }
    ODataModel *model = [type performSelector:@selector(model)];
    return model.entitySets[self.entitySetPath];
}

@end

@implementation ODRetrievalOfProperty

- (NSString *)relativePath {
    return self.propertyName;
}

- (ODType *)metadataType {
    ODType *type = [self.parentRoute metadataType];
    if (![type respondsToSelector:@selector(properties)]) {
        return nil;
    }
    NSDictionary *properties = [type performSelector:@selector(properties)];
    return properties[self.propertyName];
}

//- (NSString *)shortDescription {
//    NSString *typeDesc = [self.metadataType description];
//    return self.metadataType ? [NSString stringWithFormat:@"%@:%@", [super shortDescription], typeDesc]
//                    : [super shortDescription];
//}

@end

@implementation  ODRetrievalByBrackets

- (NSString *)bracketPart {
    return nil;
}

- (NSURL *)URL {
    if (self.knownURL) return self.knownURL;
    NSString *relative = [NSString stringWithFormat:@"%@(%@)", [self.parentRoute relativePath], [self bracketPart]];
    return [[[self.parentRoute URL] URLByDeletingLastPathComponent] URLByAppendingPathComponent:relative];
}


@end

@implementation ODRetrievalByIndex

- (NSString *)bracketPart {
    return [NSString stringWithFormat:@"%lu", (unsigned long)self.index];
}

- (NSString *)shortDescription {
    return [NSString stringWithFormat:@"%@", [self bracketPart]];
}

@end

@implementation ODRetrievalByKeys

- (NSDictionary *)keys {
    return nil;
}

- (NSString *)bracketPart {
    NSDictionary *keys = [self keys];
    id value = keys[@""];
    if (value) return [value description];
    
    NSMutableArray *list = [NSMutableArray new];
    [keys enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        [list addObject:[NSString stringWithFormat:@"%@=%@", key, [obj description]]];
    }];
    return [list componentsJoinedByString:@"&"];
}

- (NSString *)shortDescription {
    return [self bracketPart];
}

@end

@implementation ODRouteTypeDescriptor

@end

@implementation ODRouteMetadata

- (ODType *)metadataType {
    return [[ODServiceType alloc] initWithModel:self.metadataModel];
}

@end
