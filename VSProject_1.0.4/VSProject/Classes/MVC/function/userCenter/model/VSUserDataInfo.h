//
//  VSUserDataInfo.h
//  VSProject
//
//  Created by tiezhang on 15/1/13.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"
#import "VSMemberDataInfo.h"
#import "VSMemberRentInfo.h"
#import "VSWalletDataInfo.h"

@interface VSUserDataInfo : VSBaseNeedSaveDataModel

_PROPERTY_NONATOMIC_STRONG(VSMemberDataInfo, vm_memberData);    //会员信息

_PROPERTY_NONATOMIC_STRONG(VSWalletDataInfo, vm_walletData);    //钱包信息

_PROPERTY_NONATOMIC_STRONG(NSArray, __dataitem_typeof__(VSMemberRentInfo) vm_publishRents);           //发布的出租信息

//是否登录
- (BOOL)vs_isLogined;

//是否是会员
- (BOOL)vs_isVip;

@end
