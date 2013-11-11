//
//  ODResource+CollectionFields.h
//  OIDataNorth
//
//  Created by ilya on 10/30/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"

@interface ODResource (CollectionFields) 
/// Must return non-nil
- (NSString *)guessMediumDescriptionProperty;
@end
