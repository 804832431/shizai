//
//  UINavigationController+UserCenterPushVC.h
//  VSProject
//
//  Created by tiezhang on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (UserCenterPushVC)

//去登录
- (void)vs_pushToLoginVC;

//去注册
- (void)vs_pushToRegisterVC;

//去忘记密码
- (void)vs_pushToForgotVC;

//去忘记密码
- (void)vs_pushToForgotResetVC;
@end
