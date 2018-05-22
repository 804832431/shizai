//
//  UINavigationController+HomePushVC.h
//  VSProject
//
//  Created by XuLiang on 15/11/17.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (HomePushVC)

//用户中心
- (void)vs_pushToUserCenterVC;

- (void)vs_pushToUserCenterVCWithClassName:(NSString *)className;

//去登录
- (void)vs_pushToLoginVC;

//跳转web

-(void)vs_pushToJsWebVC:(NSString *)urlstr;

//跳转至H5的预约Native页面
- (void)vs_pushToAppointmentVC:(id)data;

//跳转到成功预约界面
- (void)vs_pushToSuccessAppointmentVC;

//跳转到我的预约
- (void)vs_pushToAppointmentVC;
@end
