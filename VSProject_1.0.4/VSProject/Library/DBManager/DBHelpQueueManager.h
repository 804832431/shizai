//
//  DBHelpQueueManager.h
//  VSProject
//
//  Created by tiezhang on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseManager.h"
#import <FMDB.h>

@interface DBHelpQueueManager : VSBaseManager

@property(strong,nonatomic)FMDatabaseQueue *rsFMDBQueue;

- (BOOL)db_updateSql:(NSString*)sql;

@end
