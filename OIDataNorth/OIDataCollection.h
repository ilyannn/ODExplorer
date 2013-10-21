//
//  OIDataCollection.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataResource.h"

@class OIDataEntry;

@interface OIDataCollection : OIDataResource
@property NSString *name;
- (OIDataEntry *)objectForKey:(id)objectKey;
@end
