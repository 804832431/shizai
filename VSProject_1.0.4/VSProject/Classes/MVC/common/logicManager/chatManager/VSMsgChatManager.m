//
//  VSMsgChatManager.m
//  VSProject
//
//  Created by user on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSMsgChatManager.h"

#define krecvMsgInterval    5

@interface VSMsgChatManager ()

_PROPERTY_NONATOMIC_STRONG(NSTimer, vm_recvTimer);

@end

@implementation VSMsgChatManager

DECLARE_SINGLETON(VSMsgChatManager)

- (void)vs_startListenRecvMsg
{
    [self vm_recvTimer];
}


- (void)timerRecvHandle:(id)sender
{
    //接收消息
    [self vs_recvMsgFromServer];
    
}

- (void)vs_recvMsgFromServer
{
    //获取服务器未读消息
    
    DBLog(@"recvMsg");
    
    if(YES)
    {
        [self vm_recvTimer];
    }
}

//停止接收消息
- (void)vs_stopRecvMsg
{
    INVALIDATE_TIMER(_vm_recvTimer);
    _vm_recvTimer = nil;
}

#pragma mark -- getter
_GETTER_BEGIN(NSTimer, vm_recvTimer)
{
    
    _vm_recvTimer = [NSTimer timerWithTimeInterval:krecvMsgInterval
                                            target:self
                                          selector:@selector(timerRecvHandle:)
                                          userInfo:nil
                                           repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_vm_recvTimer forMode:NSRunLoopCommonModes];
}
_GETTER_END(vm_recvTimer)

@end
