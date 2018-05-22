//
//  VSMsgChatManager.m
//  VSProject
//
//  Created by user on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSMsgChatManager.h"
#import "VSChatMsgData.h"
#import "VSDBHelperManager.h"

#define krecvMsgInterval    5


@interface VSMsgChatManager ()

_PROPERTY_NONATOMIC_STRONG(NSTimer, vm_recvTimer);

_PROPERTY_NONATOMIC_STRONG(NSThread, vm_writeMsgThread);

_PROPERTY_NONATOMIC_STRONG(NSMutableArray, vm_writeTmpCache); //写缓冲区

_PROPERTY_NONATOMIC_STRONG(NSCondition, vm_writeCondition);

_PROPERTY_NONATOMIC_STRONG(NSThread, vm_readMsgThread);

_PROPERTY_NONATOMIC_STRONG(NSCondition, vm_readCondition);

@end

@implementation VSMsgChatManager

DECLARE_SINGLETON(VSMsgChatManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self vm_writeMsgThread];
    }
    return self;
}

#pragma mark -- msg save and read
//存储本地消息
- (void)vs_msgSaveToLocal:(NSArray*__dataitem_typeof__(VSChatMsgData))msgs 
{
    if([msgs count] > 0)
    {
        [self.vm_writeCondition lock];
        [self.vm_writeTmpCache addObjectsFromArray:msgs];
        [self.vm_writeCondition signal];
        [self.vm_writeCondition unlock];
    }
}

- (void)writeHandle
{
    while (TRUE)
    {
        [self.vm_writeCondition lock];
        if([self.vm_writeTmpCache count] > 0)
        {
            VSChatMsgData *msgData = [self.vm_writeTmpCache objectAtIndex:0];
            if([msgData isKindOfClass:[VSChatMsgData class]])
            {
                [[VSDBHelperManager shareInstance] vs_insertChatMsg:msgData];
            }
                
            //存储完从临时存储数据中移除
            [self.vm_writeTmpCache removeObject:msgData];
            
            if([self.vm_writeTmpCache count] == 0)
            {
                
            }
        }
        else
        {
            [self.vm_writeCondition wait];
        }
        [self.vm_writeCondition unlock];
    }
}

//- (void)readHandle
//{
//    while (TRUE)
//    {
//
//        [self.vm_readCondition wait];
//    }
//}

//加载本地消息
- (void)vs_loadLoadMsgForSourceUID:(NSString*)sourceUID desUID:(NSString*)desUID callBack:(ThreadManagerCallBack)callBack
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *msgs = [[VSDBHelperManager shareInstance] vs_loadChatMsg:sourceUID desUI:desUID];
        if(callBack)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                callBack((msgs != nil), msgs);
            });
        }
    });
}

#pragma mark -- msg send and recv
//开启接收消息监听
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
    //先停止发送,待本次请求回来再发送下一次检索
    [self vs_stopRecvMsg];
    
    if(YES)
    {//请求结束
        [self vm_recvTimer];
    }
}

//停止接收消息
- (void)vs_stopRecvMsg
{
    INVALIDATE_TIMER(_vm_recvTimer);
    _vm_recvTimer = nil;
}

//发送消息
- (void)vs_sendMsg:(id)model
{
    
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

_GETTER_BEGIN(NSThread, vm_writeMsgThread)
{
    _vm_writeMsgThread = [[NSThread alloc]initWithTarget:self selector:@selector(writeHandle) object:nil];
    
    [_vm_writeMsgThread start];
}
_GETTER_END(vm_writeMsgThread)

_GETTER_ALLOC_BEGIN(NSMutableArray, vm_writeTmpCache)
{
}
_GETTER_END(vm_writeTmpCache)

_GETTER_ALLOC_BEGIN(NSCondition, vm_writeCondition)
{
}
_GETTER_END(vm_writeCondition)

//
//_GETTER_BEGIN(NSThread, vm_readMsgThread)
//{
//    _vm_readMsgThread = [[NSThread alloc]initWithTarget:self selector:@selector(readHandle) object:nil];
//    
//    [_vm_readMsgThread start];
//}
//_GETTER_END(vm_readMsgThread)
//
//_GETTER_ALLOC_BEGIN(NSCondition, vm_readCondition)
//{
//}
//_GETTER_END(vm_readCondition)

@end
