//
//  EnrollStepTwoViewController.h
//  VSProject
//
//  Created by apple on 10/17/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "OrderPayViewController.h"
#import "NewActivityModel.h"

@interface EnrollStepTwoViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(NewActivityModel, a_model);
@property (weak, nonatomic) IBOutlet UILabel *totalChargeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ZFBImageView;
@property (weak, nonatomic) IBOutlet UIImageView *WXImageView;
@property (weak, nonatomic) IBOutlet UIButton *payRightNowButton;

@end
