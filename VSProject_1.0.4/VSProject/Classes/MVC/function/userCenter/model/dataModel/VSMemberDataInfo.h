//
//  VSMemberDataInfo.h
//  VSProject
//
//  系统中用户会员资料数据对象
//
//  Created by tiezhang on 15/1/13.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"
#import "VSMemberContactInfo.h"

@interface VSMemberDataInfo : VSBaseDataModel

_PROPERTY_NONATOMIC_STRONG(NSString, vm_userID);        //用户ID，此ID非表中标志ID

_PROPERTY_NONATOMIC_ASSIGN(VIP_TYPE, vm_vipType);       //VIP级别

_PROPERTY_NONATOMIC_STRONG(NSString, vm_userNickName);  //昵称

_PROPERTY_NONATOMIC_STRONG(NSString, vm_userRealName);  //真实姓名

_PROPERTY_NONATOMIC_STRONG(NSString, vm_headAvar);      //头像

_PROPERTY_NONATOMIC_STRONG(NSString, vm_age);           //年龄

_PROPERTY_NONATOMIC_STRONG(NSString, vm_nature);        //性格

_PROPERTY_NONATOMIC_ASSIGN(SEX_TYPE, vm_sexType);       //性别

_PROPERTY_NONATOMIC_STRONG(NSString, vm_height);        //身高

_PROPERTY_NONATOMIC_STRONG(NSString, vm_weight);        //体重

_PROPERTY_NONATOMIC_STRONG(NSString, vm_education);     //学历

_PROPERTY_NONATOMIC_ASSIGN(BOOL,     vm_marriage);      //是否婚配

_PROPERTY_NONATOMIC_STRONG(NSString, vm_profession);    //职业

_PROPERTY_NONATOMIC_STRONG(NSString, vm_xingZuo);       //星座

_PROPERTY_NONATOMIC_STRONG(NSString, vm_hobby);         //爱好

_PROPERTY_NONATOMIC_STRONG(NSArray,  vm_pictures);      //生活照

_PROPERTY_NONATOMIC_STRONG(NSString,  vm_lastLoginTime);      //最近一次登录时间

_PROPERTY_NONATOMIC_STRONG(NSString,  vm_language);      //熟悉语种，普通话/英语

_PROPERTY_NONATOMIC_STRONG(VSMemberContactInfo, vm_contactInfo);    //联系方式

//是否登录
- (BOOL)isLogined;

//是否是会员
- (BOOL)isVip;

@end
