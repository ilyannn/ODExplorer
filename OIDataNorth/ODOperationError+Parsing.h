//
//  ODOperationError+Parsing.h
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperationError.h"

#define ODAssertOData(x, ui) { if (!(x)) \
return [ODOperationError errorWithCode:kODOperationErrorJSONNotOData userInfo:(ui)]; };

/// The test for contition; if fails, create kODOperationErrorInvalid error.
// @param x condition to be tested
// @param desc will be localized
#define ODAssertOperation(x, reason) { if (!(x)) \
return [ODOperationError errorInvalidWithReason:reason]; };

#define ODAssertODataClass(x, cls) ODAssertOData([(x) isKindOfClass:cls.class], \
(@{@"object": (x), @"expectedClass": NSStringFromClass(cls.class)}))

#define ODErrorAbstractOp    { return [ODOperationError errorWithCode:kODOperationErrorAbstractOperation \
userInfo:@{@"selector":NSStringFromSelector(_cmd), @"class":NSStringFromClass(self.class)}]; }

