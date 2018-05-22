//
//  DBHelpQueueManager.m
//  VSProject
//
//  Created by tiezhang on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "DBHelpQueueManager.h"

@implementation DBHelpQueueManager

DECLARE_SINGLETON(DBHelpQueueManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self checkDBPath];
    }
    return self;
}

- (FMDatabaseQueue*)rsFMDBQueue
{
    if (!_rsFMDBQueue)
    {
        _rsFMDBQueue = [[FMDatabaseQueue alloc] initWithPath:[self dbPath]];
    }
    return _rsFMDBQueue;
}

- (NSString*)dbPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    NSString *file = [filePath stringByAppendingPathComponent:@"db.db"];
    return file;
}

- (void)checkDBPath
{
    
    NSString *filePath = [self dbPath];
    NSLog(@"file=%@",filePath);
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:filePath];
    if (!isExist) {
        BOOL createDBResult = [fm createFileAtPath:filePath contents:nil attributes:nil];
        if(createDBResult)
        {
            @try {
                //
                NSString *crateCartTable = @"CREATE TABLE 'ld_Cart' ('productid' INTEGER   NOT NULL  DEFAULT 0, 'storeid' VARCHAR DEFAULT 0,'count'  int DEFAULT 0 ,'userid' VARCHAR ,'productStoreId' VARCHAR,'orderTypeId' VARCHAR,'catalogId' VARCHAR)";
                
                __block BOOL createTableResult;
                [self.rsFMDBQueue inDatabase:^(FMDatabase *db) {
                    [db open];
                    createTableResult =  [db executeUpdate:crateCartTable];
                    [db close];
                }];
                
                NSAssert(createDBResult, @"创建购物车表失败");
                
//                NSString *crateTable = @"CREATE TABLE 'msg_history' ('msgid' INTEGER PRIMARY KEY  NOT NULL  DEFAULT 0, 'sourceuid' VARCHAR DEFAULT 0, 'sourcename' VARCHAR DEFAULT 0, 'desuid' VARCHAR DEFAULT 0, 'desname' VARCHAR DEFAULT 0, 'msgcontent' TEXT DEFAULT 0, 'msgtime' VARCHAR)";
//                
//                
//                [self.rsFMDBQueue inDatabase:^(FMDatabase *db) {
//                    [db open];
//                    createTableResult =  [db executeUpdate:crateTable];
//                    [db close];
//                }];
//                
//                NSAssert(createDBResult, @"创建聊天表失败");
//                
//                NSString *createScanTable = @"CREATE TABLE 'scan' ('uid' TEXT PRIMARY KEY  NOT NULL  check(typeof('uid') = 'text')  DEFAULT 0, 'desuid' TEXT check(typeof('desuid') = 'text')  DEFAULT 0, 'time' TEXT check(typeof('time') = 'text')  DEFAULT 0)";
//                [self.rsFMDBQueue inDatabase:^(FMDatabase *db) {
//                    [db open];
//                    createTableResult =  [db executeUpdate:createScanTable];
//                    [db close];
//                }];
//                NSAssert(createDBResult, @"创建浏览历史表失败");
                
            }
            @catch (NSException *exception) {
                DBLog(@"%@", exception.description);
            }
            @finally {
                
            }

        }
        else
        {
            NSAssert(0, @"创建数据库文件失败");
        }
//        NSString *backupDbPath = [[NSBundle mainBundle]
//                                  
//                                  pathForResource:@"db.db"
//                                  
//                                  ofType:@""];
//        NSLog(@"backupDbPath=%@",backupDbPath);
//        [fm copyItemAtPath:filePath toPath:backupDbPath error:nil];
    }
}

- (BOOL)db_updateSql:(NSString*)sql
{
    BOOL __block result = NO;
    [self.rsFMDBQueue inDatabase:^(FMDatabase *db) {
        [db open];
        result = [db executeUpdate:sql];
        [db close];
    }];
    
    return result;
}

@end
