//
//  VSDBHelperManager.h
//  VSProject
//
//  Created by tiezhang on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "DBHelpQueueManager.h"

@class VSChatMsgData;
@interface VSDBHelperManager : VSBaseManager

//存储消息
- (BOOL)vs_insertChatMsg:(VSChatMsgData*)msg;

//加载聊天消息
- (NSArray*)vs_loadChatMsg:(NSString*)sourceUID desUI:(NSString*)desUID;

//查看历史
- (void)vs_insertScan:(id)scan;

@end
