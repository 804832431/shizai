//
//  RTXRandomProductInfoModel.h
//  VSProject
//
//  Created by XuLiang on 15/11/16.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface RTXRandomProductInfoModel : VSBaseDataModel

_PROPERTY_NONATOMIC_STRONG_OPTION (NSString, detailUrl);  //产品详情地址

_PROPERTY_NONATOMIC_STRONG_OPTION (NSString, fromDate);  //开始时间

_PROPERTY_NONATOMIC_STRONG_OPTION (NSString, largeImageUrl);  //产品图片

_PROPERTY_NONATOMIC_STRONG_OPTION (NSString, productId);  //产品Id

_PROPERTY_NONATOMIC_STRONG_OPTION (NSString, productName);  //产品名称

_PROPERTY_NONATOMIC_STRONG_OPTION (NSString, promoPrice);  //价格

_PROPERTY_NONATOMIC_STRONG_OPTION (NSString, quantity);  //库存

_PROPERTY_NONATOMIC_STRONG_OPTION (NSString, thruDate);  //结束时间,可能为””,无结束时间

_PROPERTY_NONATOMIC_STRONG_OPTION (NSString, m_description);//描述

_PROPERTY_NONATOMIC_STRONG(NSString,productAttribute);//商品规格

@end
