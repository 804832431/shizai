//
//  DBHelper.h
//  WYStarService
//
//  Created by bestjoy on 14/11/26.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import "VSBaseDataModel.h"
#import <FMDB.h>
#import "DBHelpQueue.h"
typedef void(^doSomeOperationComplete)(bool success,id result);
@interface DBHelper : DBHelpQueue

+(instancetype)shareParseObj;

@end
