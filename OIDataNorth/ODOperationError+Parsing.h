//
//  ODOperationError+Parsing.h
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperationError.h"

#define ODAssert(x, ui) { if (!(x)) \
return [ODOperationError errorWithCode:kODOperationErrorJSONNotOData userInfo:(ui)]; };

#define ODAssertClass(x, cls) ODAssert([(x) isKindOfClass:cls.class], \
(@{@"object": (x), @"expectedClass": NSStringFromClass(cls.class)}))

#define ODErrorAbstractOp    { return [ODOperationError errorWithCode:kODOperationErrorAbstractOperation \
userInfo:@{@"selector":NSStringFromSelector(_cmd), @"class":NSStringFromClass(self.class)}]; }

