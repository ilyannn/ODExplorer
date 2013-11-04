//
//  ODMetadataOperation.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODHTTPOperation.h"
#import "ODMetadataModel.h"

@interface ODMetadataOperation : ODHTTPOperation
@property (readonly) ODMetadataModel *responseModel;
@end
