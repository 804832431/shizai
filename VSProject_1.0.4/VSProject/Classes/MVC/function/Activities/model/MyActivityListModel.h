//
//  MyActivityListModel.h
//  VSProject
//
//  Created by certus on 16/1/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"
#import "ActivityModel.h"
#import "activityEnrollmentModel.h"

@interface MyActivityListModel : VSBaseNeedSaveDataModel

@property (nonatomic,strong)ActivityModel <Optional>*activity;
@property (nonatomic,strong)activityEnrollmentModel <Optional>*activityEnrollment;

@end
