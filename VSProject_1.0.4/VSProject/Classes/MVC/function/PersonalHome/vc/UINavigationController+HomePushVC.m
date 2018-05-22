//
//  UINavigationController+HomePushVC.m
//  VSProject
//
//  Created by XuLiang on 15/11/17.
//  Copyright © 2015年 user. All rights reserved.
//

#import "UINavigationController+HomePushVC.h"
#import "CenterViewController.h"
#import "VSUserLoginViewController.h"
#import "VSJsWebViewController.h"
#import "RTXAppointmentViewController.h"
#import "RTXCompleteAppointmentViewController.h"
#import "RTXMyAppointmentViewController.h"

@implementation UINavigationController (HomePushVC)
//用户中心
- (void)vs_pushToUserCenterVC{
    CenterViewController *centervc = _ALLOC_OBJ_([CenterViewController class]);
    [self vs_pushToDesVCExcept:centervc];
}
- (void)vs_pushToUserCenterVCWithClassName:(NSString *)className{
    if (!className) {
        [self vs_pushToUserCenterVC];
    }else{
        CenterViewController *centervc = _ALLOC_OBJ_([CenterViewController class]);
        centervc.className = className;
        [self vs_pushToDesVCExcept:centervc];
    }
}
//去登录
- (void)vs_pushToLoginVC{
    VSUserLoginViewController *loginvc = _ALLOC_VC_CLASS_([VSUserLoginViewController class]);
    [self vs_pushToDesVCExcept:loginvc];
}

-(void)vs_pushToJsWebVC:(NSString *)urlstr{
    NSURL *jumpUrl = [NSURL URLWithString:urlstr];
    VSJsWebViewController *jswebvc = _ALLOC_OBJ_([VSJsWebViewController class]);
    jswebvc.webUrl = jumpUrl;
//    [self vs_pushToDesVCExcept:jswebvc];
    //modify by Thomas [跳转问题]---start
    [self pushViewController:jswebvc animated:YES];
    //modify by Thomas [跳转问题]---end
}

//跳转至H5的预约Native页面
- (void)vs_pushToAppointmentVC:(id)data{
    RTXAppointmentViewController *appointmentVC = _ALLOC_OBJ_([RTXAppointmentViewController class]);
    [self vs_pushToDesVCExcept:appointmentVC];
}
//跳转到成功预约界面
- (void)vs_pushToSuccessAppointmentVC{
    RTXCompleteAppointmentViewController *completvc = _ALLOC_VC_CLASS_([RTXCompleteAppointmentViewController class]);
    [self vs_pushToDesVCExcept:completvc];
}
//跳转到我的预约
- (void)vs_pushToAppointmentVC{
    RTXMyAppointmentViewController *myAppointmentvc = _ALLOC_VC_CLASS_([RTXMyAppointmentViewController class]);
    [self vs_pushToDesVCExcept:myAppointmentvc];
}
@end
