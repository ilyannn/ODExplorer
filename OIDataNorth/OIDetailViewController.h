//
//  OIDetailViewController.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface OIDetailViewController : UIViewController

@property (strong, nonatomic) Product *detailItem;

@property (weak, nonatomic) IBOutlet UITextView *productDescription;
@property (weak, nonatomic) IBOutlet UITextView *supplierDescription;

@end
