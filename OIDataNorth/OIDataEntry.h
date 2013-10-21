//
//  OIDataEntry.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataResource.h"

@class OIDataCollection;

@interface OIDataEntry : OIDataResource
- (NSDictionary *)keys;
- (void)setKeys:(id)keys;

@property (nonatomic) OIDataCollection *parent;
@end
