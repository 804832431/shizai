//
//  VSBaseUserAccountParm.h
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseParmModel.h"

@interface VSBaseUserAccountParm : VSBaseParmModel

_PROPERTY_NONATOMIC_STRONG(NSString, username);   //账号

_PROPERTY_NONATOMIC_STRONG(NSString, password);  //密码

_PROPERTY_NONATOMIC_STRONG(NSString, captcha);  //验证码

@end
