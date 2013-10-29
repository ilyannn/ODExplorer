//
//  OIDataEntry.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntity.h"
#import "ODCollection.h"
#import "ODEntityRetrieval.h"
#import "ODRetrieveOperation.h"
#import "ODActionOperation.h"

#import "NSData+Base64.h"

@interface ODEntity ()
@property (nonatomic) NSMutableDictionary *localProperties;
@property (nonatomic) NSMutableDictionary *remoteProperties;
// @property (nonatomic) NSMutableDictionary *navigationProperties;
@end

@implementation ODEntity {
    NSURL *_knownURL;
    NSMutableDictionary *_localProperties;
    NSMutableDictionary *_remoteProperties;
}

// This is a designated initializer.
- (id)init {
    self = [super init];
    if (self) {
        self.kind = ODResourceKindEntity;
    }
    return self;
}

@synthesize localProperties = _localProperties;
@synthesize remoteProperties = _remoteProperties;

- (instancetype)initFromDict:(NSDictionary *)dict parentInfo:(id <ODRetrieving> )parentInfo {
    ODRetrievalInfo *info;
    return [self initWithRetrievalInfo:info];
}

- (NSURL *)URL {
    if (_knownURL) {
        return _knownURL;
    }
    
    if (self.retrievalInfo) {
        return [self.retrievalInfo URL];
    }
    
    return nil;
}

+ (ODEntityType *)entityType {
    //    static
    ODEntityType *_entityType;
    //   if (!_entityType) {
    _entityType = [ODEntityType new];
    _entityType.className = NSStringFromClass(self);
    //    }
    return _entityType;
}

- (ODEntityType *)entityType {
    return [self.class entityType];
}

- (id)initFromDict:(NSDictionary *)dict {
    if (self = [self init]) {
        [self updateFromDict:dict];
    }
    return self;
}

/// Answer from http://stackoverflow.com/a/6065278/115200
+ (NSDate *)dateFromJSONString:(NSString *)string {
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

- (void)updateFromDict:(NSDictionary *)dict {
    _remoteProperties = [NSMutableDictionary new];
    _navigationProperties = [NSMutableDictionary new];
    [dict enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:NSDictionary.class]) {
            ODEntity *entity = [[ODEntity alloc] initFromDict:obj];
            ODRetrievalOfProperty *retrieval = [ODRetrievalOfProperty new];
            retrieval.parent = self.retrievalInfo;
            retrieval.propertyName = key;
            entity.retrievalInfo = retrieval;
            _navigationProperties[key] = entity;
        } else if ([obj isKindOfClass:[NSNull class]]) {
            // "convert" to nil
        } else if ([obj isKindOfClass:[NSString class]]) {
            // Is this a date?
            if ([obj length] < 1000) {
                id value = nil;
                if (!!(value = [self.dateTimeFormatter dateFromString:obj])
                    || !!(value = [ODEntity dateFromJSONString:obj])
                    ||(!!(value = [NSURL URLWithString:obj]) && !!([(NSURL *)value scheme].length))
                ) {
                        obj = value;
                }
            } else {
                NSData *data  = [NSData dataFromBase64String:obj];
                if (data) {
                    UIImage *image = [UIImage imageWithData:data];
                    obj = image ? image : data;
                }
            }
            _remoteProperties[key] = obj;
        } else {
            _remoteProperties[key] = obj;
        }
    }];
    
    _localProperties = [_remoteProperties mutableCopy];
}

- (id)valueForKey:(NSString *)key {
    id value = self.localProperties[key];
    if (value) return value;
    if (self.retrievedOn) return nil;
    
    //    [[self.retrievalInfo readManager] retrieveProperty:key ofEntity:self];
    return self.localProperties[key];
}

- (void)retrieve {
    ODRetrieveOperation *operation = [ODRetrieveOperation new];
    operation.resource = self;
    [self handleOperation:operation];
}

- (id)navigationProperty:(NSString *)name propertyType:(ODEntityType *)entityType {
    ODResource *result = self.navigationProperties[name];
    if (result) return result;
    
    //    target.retrievalInfo.parent = self.retrievalInfo;
    
    ODRetrievalOfProperty *retrievalInfo = [ODRetrievalOfProperty new];
    retrievalInfo.parent = self.retrievalInfo;
    retrievalInfo.propertyName = name;
    
    return [entityType entityWithInfo:retrievalInfo];
}

- (id)navigationCollection:(NSString *)name entityType:(ODEntityType *)entityType {
    return [ODCollection collectionForProperty:name entityType:entityType inEntity:self];
}

- (NSString *)longDescription {
    return [@[[self description], [self.localProperties description]]
            componentsJoinedByString: @"\n"];
}

- (void)performAction:(NSString *)actionName {
    [self performAction:actionName withParameters:nil];
}

- (void)performAction:(NSString *)actionName withParameters:(NSDictionary *)params {
    ODActionOperation *operation = [ODActionOperation new];
    operation.resource = self;
    operation.parameters = [params mutableCopy];
    operation.actionName = actionName;
    
    [self handleOperation:operation];
}

@end
