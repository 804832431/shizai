//
//  VSMemberRewardInfo.h
//  VSProject
//
//  系统中用户付费查看的联系方式数据对象
//
//  Created by user on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface VSMemberContactInfo : VSBaseDataModel

_PROPERTY_NONATOMIC_ASSIGN(BOOL, vm_hasTel);
_PROPERTY_NONATOMIC_STRONG(NSString, vm_tel);       //手机号

_PROPERTY_NONATOMIC_ASSIGN(BOOL, vm_hasEmail);
_PROPERTY_NONATOMIC_STRONG(NSString, vm_email);     //邮箱

_PROPERTY_NONATOMIC_ASSIGN(BOOL, vm_hasQQ);
_PROPERTY_NONATOMIC_STRONG(NSString, vm_qq);        //qq

_PROPERTY_NONATOMIC_ASSIGN(BOOL, vm_hasWx);
_PROPERTY_NONATOMIC_STRONG(NSString, vm_wx);        //微信

@end
