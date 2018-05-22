//
//  NewPolicyModel.h
//  VSProject
//
//  Created by apple on 11/4/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"

@interface NewPolicyModel : VSBaseNeedSaveDataModel
@property (nonatomic,copy)NSString <Optional>*policyId;	//政策id
@property (nonatomic,copy)NSString <Optional>*policyName;	//政策名称
@property (nonatomic,copy)NSString <Optional>*partner;	//政策合作方
@property (nonatomic,copy)NSString <Optional>*publishDate;	//政策上线时间
@property (nonatomic,copy)NSString <Optional>*isCollected;	//"是否已收藏"	"Y:是N:否"
@property (nonatomic,copy)NSString <Optional>*isAllowApply;	//是否可以申请政策	"Y:是N:否"
@property (nonatomic,copy)NSString <Optional>*policyStatus;	//政策申请状态	"NOT_START：未开始，STARTED：已开始，COMPLETED：已结束APPLIED：已申请"
@property (nonatomic,copy)NSString <Optional>*publicityStatus;	//公示状态，	"Y：已公示N：未公示"
@property (nonatomic,copy)NSString <Optional>*policyDetail;	//政策详情url

// add by pangchao 1.6.0
@property (nonatomic,copy)NSString <Optional>*applyDateBegin;	//申请开始日期
@property (nonatomic,copy)NSString <Optional>*applyDateEnd;	//申请截止时间
@property (nonatomic,copy)NSString <Optional>*minSubsidy;	//最小补贴
@property (nonatomic,copy)NSString <Optional>*maxSubsidy;	//最大补贴
@end
