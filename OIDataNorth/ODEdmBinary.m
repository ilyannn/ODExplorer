//
//  ODEdmBinary.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEdmBinary.h"
#import "NSData+Base64.h"

@implementation ODEdmBinary

- (instancetype) init {
    return [super initWithName:@"Binary"];
}

- (NSData *)valueForJSONString:(NSString *)obj {
    return [NSData dataFromBase64String:obj];
/*    if (!data) {
        return nil;
    }
    UIImage *image = [UIImage imageWithData:data];
    return image ? image : data;
*/  
}

@end
