//
//  Bidder.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"

@interface Bidder : VSBaseNeedSaveDataModel

@property (nonatomic,strong)NSNumber <Optional>* id	;//企业id
@property (nonatomic,strong)NSString <Optional>* enterpriseName	;//企业名称
@property (nonatomic,strong)NSString <Optional>* enterpriseLegalPerson	;//企业法人
@property (nonatomic,strong)NSString <Optional>* enterpriseIdentity	;//企业工商注册号
@property (nonatomic,strong)NSString <Optional>* contactName	;//联系人
@property (nonatomic,strong)NSString <Optional>* contactNumber;//	联系方式
@property (nonatomic,strong)NSString <Optional>* failReason; //失败原因

@end
