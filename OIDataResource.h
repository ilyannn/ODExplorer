//
//  OIDataResource.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

// This is an abstract class
@interface OIDataResource : NSObject

// This is a parent resource.
@property (readwrite, nonatomic) OIDataResource *parent;
- (instancetype)initWithParent:(OIDataResource *)parent;

@property (readonly, nonatomic) NSURL *URL;
@property (readonly, nonatomic) NSString *relativePath;
@property (readonly, nonatomic) NSURL *baseURL;

@end
