//
//  EnrollStepOneViewController.h
//  VSProject
//
//  Created by apple on 10/17/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "NewActivityModel.h"

@interface EnrollStepOneViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(NewActivityModel, a_model);

@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *chargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalChargeLabel;

@end
