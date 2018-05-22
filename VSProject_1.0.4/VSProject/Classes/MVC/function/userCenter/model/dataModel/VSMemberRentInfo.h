//
//  VSMemberRentInfo.h
//  VSProject
//
//  系统中用户租赁信息数据对象
//
//  Created by user on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface VSMemberRentInfo : VSBaseDataModel

_PROPERTY_NONATOMIC_ASSIGN(RENT_TYPE, vm_rentType);     //出租类型

_PROPERTY_NONATOMIC_STRONG(NSString, vm_reward);        //出租酬金

_PROPERTY_NONATOMIC_STRONG(NSString, vm_service);       //提供服务(见父母亲友, 社交聚会, 诳街购物, 唱歌看电影, 聊天叫醒服务)

_PROPERTY_NONATOMIC_STRONG(NSString, vm_rentTime);      //出租时间

_PROPERTY_NONATOMIC_STRONG(NSString, vm_rentCity);      //出租地域

_PROPERTY_NONATOMIC_STRONG(NSString, vm_introduce);     //自我介绍

_PROPERTY_NONATOMIC_STRONG(NSString, vm_note);          //备注

_PROPERTY_NONATOMIC_ASSIGN(RENT_CATEGORY_TYPE, vm_categoryType);    //出租类别

@end
