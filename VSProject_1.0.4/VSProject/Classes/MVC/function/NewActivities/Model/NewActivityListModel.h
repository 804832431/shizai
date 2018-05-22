//
//  NewActivityListModel.h
//  VSProject
//
//  Created by apple on 10/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"
#import "NewActivityModel.h"

@interface NewActivityListModel : VSBaseNeedSaveDataModel

@property (nonatomic,copy)NSString <Optional>*count;
@property (nonatomic,copy)NSString <Optional>*hasNext;
@property (nonatomic,strong)NSArray <NewActivityModel *>*activityList;

@end
