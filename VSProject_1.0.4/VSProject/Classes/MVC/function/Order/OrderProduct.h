//
//  OrderProduct.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderProduct : VSBaseModel

_PROPERTY_NONATOMIC_STRONG(NSString,productId);//	商品id
_PROPERTY_NONATOMIC_STRONG(NSString,productName);//	商品名称
_PROPERTY_NONATOMIC_STRONG(NSString,productTypeId);//	商品类型
_PROPERTY_NONATOMIC_STRONG(NSString,quantity);//	数量
_PROPERTY_NONATOMIC_STRONG(NSString,smallImageUrl);//	缩略图
_PROPERTY_NONATOMIC_STRONG(NSString,unitPrice);//	单价

_PROPERTY_NONATOMIC_STRONG(NSString,productAttribute);//商品规格

@end
