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
#import "RTXCheckPermissionModel.h"
#import "RTXProjectInfoModel.h"
#import "RTXUserInfoModel.h"
#import "AdressModel.h"
#import "WeatherModel.h"

@interface VSUserDataInfo : VSBaseNeedSaveDataModel

_PROPERTY_NONATOMIC_STRONG(NSString, vm_orderTypeId);//当前选择应用的订单类型
_PROPERTY_NONATOMIC_STRONG(NSString, vm_catalogId);//当前选择应用Id
_PROPERTY_NONATOMIC_STRONG(NSString, vm_from);//点进应用的是B还是C
_PROPERTY_NONATOMIC_STRONG(NSString, vm_visitType);//应用类型原生或H5（NATIVE/H5）


_PROPERTY_NONATOMIC_STRONG(RTXProjectInfoModel, vm_projectInfo);    //项目信息

_PROPERTY_NONATOMIC_STRONG(NSString, vm_projectImg_day);    //项目白天图片

_PROPERTY_NONATOMIC_STRONG(NSString, vm_projectImg_night);    //项目晚上图片

_PROPERTY_NONATOMIC_STRONG(RTXUserInfoModel, vm_userInfo);    //用户信息

_PROPERTY_NONATOMIC_STRONG(AdressModel, vm_defaultAdressInfo);    //默认地址

_PROPERTY_NONATOMIC_STRONG(WeatherModel, vm_WeatherInfo);    //天气

_PROPERTY_NONATOMIC_ASSIGN(BOOL, vm_haveNewMessage);    //新消息

_PROPERTY_NONATOMIC_ASSIGN(BOOL, vm_hasUnreadFWZL);    //租房信息消息

//_PROPERTY_NONATOMIC_STRONG(VSMemberDataInfo, vm_memberData);    //会员信息
//
//_PROPERTY_NONATOMIC_STRONG(VSWalletDataInfo, vm_walletData);    //钱包信息

//_PROPERTY_NONATOMIC_STRONG(NSArray, __dataitem_typeof__(VSMemberRentInfo) vm_publishRents);           //发布的出租信息

//是否登录
//- (BOOL)vs_isLogined;

////是否是会员
//- (BOOL)vs_isVip;

@end
