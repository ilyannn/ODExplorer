//
//  ODServiceType.h
//  OIDataNorth
//
//  Created by ilya on 11/5/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCollectionType.h"
#import "ODMetadataModel.h"

@interface ODServiceType : ODCollectionType
- (instancetype)initWithModel:(ODMetadataModel *)model;
@property (readonly) ODMetadataModel *model;
@end
