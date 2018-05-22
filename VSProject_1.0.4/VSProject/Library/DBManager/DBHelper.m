//
//  DBHelper.m
//  WYStarService
//
//  Created by bestjoy on 14/11/26.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper
static DBHelper * g_dbhelper=nil;
+(instancetype)shareParseObj
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_dbhelper = _ALLOC_OBJ_(DBHelper);
    });
    return g_dbhelper;
}
-(void)openDB:(NSString*)DBName
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [paths objectAtIndex:0];
//    NSString *file = [filePath stringByAppendingPathComponent:DBName];
//    NSLog(@"%@",file);
//    NSFileManager *fm = [NSFileManager defaultManager];
//    BOOL isExist = [fm fileExistsAtPath:DBName];
//    if (!isExist) {
//        NSString *backupDbPath = [[NSBundle mainBundle]
//                                  
//                                  pathForResource:DBName
//                                  
//                                  ofType:@""];
//        NSLog(@"%@",backupDbPath);
//        [fm copyItemAtPath:backupDbPath toPath:file error:nil];
//        
//        db=[FMDatabase databaseWithPath:backupDbPath];
//        if (![db open]) {
//            NSLog(@"Could not open db.");
//            return ;
//        }
//        else
//        {
//            NSLog(@"open db successful.");
//        }
//    }else{
//        NSLog(@"文件存在");
//    }
}

@end
