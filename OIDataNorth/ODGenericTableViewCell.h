//
//  ODCollectionTableViewCell.h
//  OIDataNorth
//
//  Created by ilya on 10/30/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceTableViewCell.h"
#import "ODCollection.h"

@interface ODGenericTableViewCell : ODResourceTableViewCell
@property (nonatomic) ODResource<ODCollectionAccessing> *resource;

@end
