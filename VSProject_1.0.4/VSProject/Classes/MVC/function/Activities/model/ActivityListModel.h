//
//  ActivityListModel.h
//  VSProject
//
//  Created by certus on 16/1/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"
#import "ActivityModel.h"

@interface ActivityListModel : VSBaseNeedSaveDataModel

@property (nonatomic,strong)NSString <Optional>*count;
@property (nonatomic,strong)NSString <Optional>*hasNext;
@property (nonatomic,strong)NSString <Optional>*imagePrefix;
@property (nonatomic,strong)NSArray <ActivityModel *>*activityList;

@end
