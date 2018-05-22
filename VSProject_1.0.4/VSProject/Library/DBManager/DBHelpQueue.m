//
//  DBHelpQueue.m
//  WYDZBXK
//
//  Created by bestjoy on 15/1/8.
//  Copyright (c) 2015年 zhangtie. All rights reserved.
//

#import "DBHelpQueue.h"

@implementation DBHelpQueue

static DBHelpQueue * g_dbhelper=nil;
+(instancetype)shareDBHelpQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_dbhelper = _ALLOC_OBJ_(DBHelpQueue);
    });
    return g_dbhelper;
}

- (FMDatabaseQueue*)rsFMDBQueue
{
    if (!_rsFMDBQueue)
    {
        NSLog(@"dbpath=%@",[self dbPath]);
        _rsFMDBQueue = [[FMDatabaseQueue alloc] initWithPath:[self dbPath]];
    }
    return _rsFMDBQueue;
}

- (NSString*)dbPath
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    NSString *file = [filePath stringByAppendingPathComponent:@"db.db"];
    NSLog(@"file=%@",file);
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:@"db.db"];
    if (!isExist) {
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  
                                  pathForResource:@"db.db"
                                  
                                  ofType:@""];
        NSLog(@"backupDbPath=%@",backupDbPath);
        [fm copyItemAtPath:file toPath:backupDbPath error:nil];
        return backupDbPath;
    }
    return file;
}


@end
