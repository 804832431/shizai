//
//  UINavigationController+FindPush.h
//  VSProject
//
//  Created by tiezhang on 15/3/30.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (FindPush)

//去导师VC
- (void)vs_pushToTeacherVC;

//去成功案例VC
- (void)vs_pushToSuccessCaseVC;

//去招聘vc
- (void)vs_pushToJobVC;

//去新注册会员VC
- (void)vs_pushToNewMemberVC;

//去娱乐VC
- (void)vs_pushToEnjoyVC;

@end
