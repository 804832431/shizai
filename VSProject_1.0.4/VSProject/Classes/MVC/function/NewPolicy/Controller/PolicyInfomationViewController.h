//
//  PolicyInfomationViewController.h
//  VSProject
//
//  Created by apple on 11/7/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "NewPolicyModel.h"

@interface PolicyInfomationViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(NewPolicyModel, p_model);
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;

@property (weak, nonatomic) IBOutlet UITextField *enterpriseNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *areaNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *legalPersonTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactPersonTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@end
