//
//  ForgotResetViewController.h
//  VSProject
//
//  Created by XuLiang on 15/10/29.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseAccountViewController.h"
#import "LoginAccountModel.h"

@interface ForgotResetViewController : VSBaseAccountViewController

_PROPERTY_NONATOMIC_STRONG(NSString, phoneNumber);
_PROPERTY_NONATOMIC_STRONG(NSString, titleName);
_PROPERTY_NONATOMIC_STRONG(LoginAccountModel, passmodel);
_PROPERTY_NONATOMIC_STRONG(LoginAccountModel, suremodel);

@end
