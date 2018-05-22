//
//  UINavigationController+PersonPushVC.m
//  VSProject
//
//  Created by user on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "UINavigationController+PersonPushVC.h"
#import "VSVisitListViewController.h"
#import "VSChatMsgListViewController.h"

@implementation UINavigationController (PersonPushVC)

//去访客列表
- (void)vs_pushToVisitListVC
{
    VSVisitListViewController *vvc = _ALLOC_VC_CLASS_([VSVisitListViewController class]);
    [self vs_pushToDesVCExcept:vvc];
}

//去聊天
- (void)vs_pushToChatVC
{
    VSChatMsgListViewController *cvc = _ALLOC_VC_CLASS_([VSChatMsgListViewController class]);
    [self vs_pushToDesVCExcept:cvc];
}

@end
