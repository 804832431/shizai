//
//  CompleteEnrollInfoViewController.h
//  VSProject
//
//  Created by apple on 10/17/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "NewActivityModel.h"

@interface CompleteEnrollInfoViewController : VSBaseViewController
_PROPERTY_NONATOMIC_STRONG(NewActivityModel, a_model);
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *workTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end
