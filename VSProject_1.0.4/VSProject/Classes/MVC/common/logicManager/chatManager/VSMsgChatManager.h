//
//  VSMsgChatManager.h
//  VSProject
//
//  Created by user on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseLogicManager.h"

@interface VSMsgChatManager : VSBaseLogicManager

//接收消息
- (void)vs_recvMsgFromServer;

//开启接收消息监听
- (void)vs_startListenRecvMsg;

//停止接收消息
- (void)vs_stopRecvMsg;

@end
