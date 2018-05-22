//
//  DBHelpQueue.h
//  WYDZBXK
//
//  Created by bestjoy on 15/1/8.
//  Copyright (c) 2015年 zhangtie. All rights reserved.
//

#import "VSBaseDataModel.h"
#import <FMDB.h>
@interface DBHelpQueue : VSBaseDataModel

@property(strong,nonatomic)FMDatabaseQueue *rsFMDBQueue;

+(instancetype)shareDBHelpQueue;



@end
