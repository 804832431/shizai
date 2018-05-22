//
//  ShoppingCartInfoDTO.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseModel.h"

@interface ShoppingCartInfoDTO : VSBaseModel


_PROPERTY_NONATOMIC_STRONG(NSString,categoryName)	;//	商户名称
_PROPERTY_NONATOMIC_STRONG(NSString,totalQuantity)	;//	购买商品总数量
_PROPERTY_NONATOMIC_STRONG(NSString,promoAmount)	;//	总优惠价格
_PROPERTY_NONATOMIC_STRONG(NSString,totalAmount)	;//	购物车所有产品总价
_PROPERTY_NONATOMIC_STRONG(NSString,totalShipping)	;//	运费（UI界面显示的运费）
_PROPERTY_NONATOMIC_STRONG(NSString,totalPayAmount)	;//	支付价格（UI界面显示实付价格）
_PROPERTY_NONATOMIC_STRONG(NSArray,cartItemsList)	;//	购买产品列表信息

_PROPERTY_NONATOMIC_STRONG(NSString,productAttribute);//产品规格



@end
