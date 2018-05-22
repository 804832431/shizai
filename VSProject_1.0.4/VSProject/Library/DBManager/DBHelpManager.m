//
//  DBHelpManager.m
//  WYDZBXK
//
//  Created by bestjoy on 15/1/8.
//  Copyright (c) 2015年 zhangtie. All rights reserved.
//

#import "DBHelpManager.h"

@implementation DBHelpManager
static DBHelpManager * g_dbhelper=nil;
+(instancetype)shareDBHelpQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_dbhelper = _ALLOC_OBJ_(DBHelpManager);
    });
    return g_dbhelper;
}

- (FMResultSet*)queueSomthing
{
    __block FMResultSet *sett = [[FMResultSet alloc] init];
    [self.rsFMDBQueue inDatabase:^(FMDatabase *db) {
        [db open];
        sett = [db executeQuery:@""];
        [db close];
    }];
    return sett;
}


@end
