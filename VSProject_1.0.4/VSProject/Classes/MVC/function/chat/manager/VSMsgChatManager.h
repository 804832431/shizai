//
//  VSMsgChatManager.h
//  VSProject
//
//  Created by user on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseLogicManager.h"

typedef void(^ThreadManagerCallBack)(BOOL sqlFlag, id resultData);


@interface VSMsgChatManager : VSBaseLogicManager

#pragma mark -- msg save and read
//存储消息
- (void)vs_msgSaveToLocal:(NSArray*__dataitem_typeof__(VSChatMsgData))msgs;

//加载本地消息
- (void)vs_loadLoadMsgForSourceUID:(NSString*)sourceUID desUID:(NSString*)desUID callBack:(ThreadManagerCallBack)callBack;

#pragma mark -- msg send and recv
//接收消息
- (void)vs_recvMsgFromServer;

//开启接收消息监听
- (void)vs_startListenRecvMsg;

//停止接收消息
- (void)vs_stopRecvMsg;

//发送消息
- (void)vs_sendMsg:(id)model;


@end
