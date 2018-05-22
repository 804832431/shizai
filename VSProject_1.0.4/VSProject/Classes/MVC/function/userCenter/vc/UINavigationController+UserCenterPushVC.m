//
//  UINavigationController+UserCenterPushVC.m
//  VSProject
//
//  Created by tiezhang on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "UINavigationController+UserCenterPushVC.h"
#import "VSUserRegisterViewController.h"
#import "VSUserLoginViewController.h"
#import "VSForgotViewController.h"
#import "LDResisterViewController.h"
#import "ForgotResetViewController.h"

@implementation UINavigationController (UserCenterPushVC)

//去登录
- (void)vs_pushToLoginVC
{
    VSUserLoginViewController *uvc = _ALLOC_OBJ_([VSUserLoginViewController class]);
    [self vs_pushToDesVCExcept:uvc];
}

//去注册
- (void)vs_pushToRegisterVC
{
    LDResisterViewController *rvc = _ALLOC_OBJ_([LDResisterViewController class]);
    [self vs_pushToDesVCExcept:rvc];
}

//去忘记密码_获取验证码
- (void)vs_pushToForgotVC
{
    VSForgotViewController *fvc = _ALLOC_VC_CLASS_([VSForgotViewController class]);
    [self vs_pushToDesVCExcept:fvc];
}

//去忘记密码_重设密码
- (void)vs_pushToForgotResetVC
{
    ForgotResetViewController *fvc = _ALLOC_VC_CLASS_([ForgotResetViewController class]);
    [self vs_pushToDesVCExcept:fvc];
}

@end
