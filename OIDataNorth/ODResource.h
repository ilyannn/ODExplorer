//
//  OIDataResource.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODManagingProtocols.h"

// This is an abstract class
@interface ODResource : NSObject

@property (readonly, nonatomic) NSURL *URL;
@property (nonatomic) ODResource *parent;
@property (nonatomic) NSMutableDictionary *strongChildren;

@property (nonatomic) id <ODFaultManaging> readManager;
@property (nonatomic) id <ODChangeManaging> changeManager;

@end
