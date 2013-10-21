//
//  OIDataRetrieveCollection.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataRetrieve.h"

@interface OIDataRetrieveCollection : OIDataRetrieve
@property (readwrite, nonatomic) id filter;
@property (readwrite, nonatomic) id select;
@property (readwrite, nonatomic) id orderBy;

@end
