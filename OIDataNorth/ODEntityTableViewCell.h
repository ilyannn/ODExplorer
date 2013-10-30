//
//  ODEntityTableViewCell.h
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceTableViewCell.h"

#import "ODEntity.h"

@interface ODEntityTableViewCell : ODResourceTableViewCell

@property (nonatomic) ODResource<ODEntityAccessing> *resource;

// It is expected that this will in fact be a mutable array which may
// change its contents. It is understood that the cell will have
// to be refreshed manually from the outside for the changes to take effect.
@property (nonatomic) NSArray *headlineProperties;

@end
