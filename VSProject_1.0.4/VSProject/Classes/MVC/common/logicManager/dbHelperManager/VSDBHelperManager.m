//
//  VSDBHelperManager.m
//  VSProject
//
//  Created by tiezhang on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSDBHelperManager.h"
#import "VSChatMsgData.h"

#define kmsgTableName   @"msg_history"

@implementation VSDBHelperManager

DECLARE_SINGLETON(VSDBHelperManager)

//存储消息
- (BOOL)vs_insertChatMsg:(VSChatMsgData*)msg
{
//    INSERT INTO msg_history VALUES (1, '112', 'Xuanwumen 10', '123', 'shanghai', '我爱你', '2014-01-15 12:22:20')
    @try {
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@ VALUES (%ld, '%@', '%@', '%@', '%@', '%@', '%@')", kmsgTableName, (long)msg.vm_msgId, msg.vm_sourceUID, msg.vm_sourceName, msg.vm_desUID, msg.vm_desName, msg.vm_msgContent, msg.vm_msgTime];
        return [[DBHelpQueueManager shareInstance] db_updateSql:insertSql];
    }
    @catch (NSException *exception) {
        DBLog(@"%@", [exception reason]);
    }
    @finally {
        return NO;
    }

    
}

//加载聊天消息
- (NSArray*)vs_loadChatMsg:(NSString*)sourceUID desUI:(NSString*)desUID
{
    __block NSMutableArray *result = [NSMutableArray array];
    @try {
        [[DBHelpQueueManager shareInstance].rsFMDBQueue inDatabase:^(FMDatabase *db)   {
            [db open];
            FMResultSet *resset = [db executeQuery:[NSString stringWithFormat:@"select * from %@ where sourceuid = '%@' and desuid = '%@' order by msgid asc", kmsgTableName, sourceUID, desUID]]; //按照时间戳从小到大排列
            while ([resset next])
            {
                VSChatMsgData *chatMsg = _ALLOC_OBJ_(VSChatMsgData);
                chatMsg.vm_msgId       = [resset intForColumn:@"msgid"];
                chatMsg.vm_sourceUID   = [resset stringForColumn:@"sourceuid"];
                chatMsg.vm_sourceName  = [resset stringForColumn:@"sourcename"];
                
                chatMsg.vm_desUID      = [resset stringForColumn:@"desuid"];
                chatMsg.vm_desName     = [resset stringForColumn:@"desname"];
                
                chatMsg.vm_msgContent  = [resset stringForColumn:@"msgcontent"];
                chatMsg.vm_msgTime     = [resset stringForColumn:@"msgtime"];
                [result addObject:chatMsg];
            }
            [db close];
        }];
        
        return result;
    }
    @catch (NSException *exception) {
        DBLog(@"%@", [exception reason]);
    }
    @finally {
    }

}

//查看历史
- (void)vs_insertScan:(id)scan
{
    
}

@end
