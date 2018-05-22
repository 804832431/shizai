//
//  UINavigationController+FindPush.m
//  VSProject
//
//  Created by tiezhang on 15/3/30.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "UINavigationController+FindPush.h"
#import "VSSuccessCaseViewController.h"
#import "VSJobMeetingViewController.h"
#import "VSNewMemberViewController.h"
#import "VSTeacherViewController.h"

@implementation UINavigationController (FindPush)

//去导师VC
- (void)vs_pushToTeacherVC
{
    VSTeacherViewController *tvc = _ALLOC_VC_CLASS_([VSTeacherViewController class]);
    [self vs_pushToDesVCExcept:tvc];
}

//去成功案例VC
- (void)vs_pushToSuccessCaseVC
{
    VSSuccessCaseViewController *svc = _ALLOC_VC_CLASS_([VSSuccessCaseViewController class]);
    [self vs_pushToDesVCExcept:svc];
}

//去招聘vc
- (void)vs_pushToJobVC
{
    VSJobMeetingViewController *svc = _ALLOC_VC_CLASS_([VSJobMeetingViewController class]);
    [self vs_pushToDesVCExcept:svc];
}

//去新注册会员VC
- (void)vs_pushToNewMemberVC
{
    VSNewMemberViewController *svc = _ALLOC_VC_CLASS_([VSNewMemberViewController class]);
    [self vs_pushToDesVCExcept:svc];
}

//去娱乐VC
- (void)vs_pushToEnjoyVC
{
    
}

@end
