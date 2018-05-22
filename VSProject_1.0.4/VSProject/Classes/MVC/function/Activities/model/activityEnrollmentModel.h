//
//  activityEnrollmentModel.h
//  VSProject
//
//  Created by certus on 16/1/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"

@interface activityEnrollmentModel : VSBaseNeedSaveDataModel

@property (nonatomic,strong)NSString <Optional>*activityId;
@property (nonatomic,strong)NSString <Optional>*chargeTotal;
@property (nonatomic,strong)NSString <Optional>*createTime;
@property (nonatomic,strong)NSString <Optional>*formComment;
@property (nonatomic,strong)NSString <Optional>*formName;
@property (nonatomic,strong)NSString <Optional>*formNumber;
@property (nonatomic,strong)NSString <Optional>*formQuantity;
@property (nonatomic,strong)NSString <Optional>*id;
@property (nonatomic,strong)NSString <Optional>*partyId;
@property (nonatomic,strong)NSString <Optional>*payType;
@property (nonatomic,strong)NSString <Optional>*status;
@property (nonatomic,strong)NSString <Optional>*tradeNumber;

@end
