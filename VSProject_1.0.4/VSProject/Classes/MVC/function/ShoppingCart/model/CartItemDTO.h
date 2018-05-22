//
//  CartItemDTO.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseModel.h"

@interface CartItemDTO : VSBaseModel
_PROPERTY_NONATOMIC_STRONG(NSString,ItemTotalPrice)	;//	产品总价
_PROPERTY_NONATOMIC_STRONG(NSString,ItemPrice)	;//	产品单价
_PROPERTY_NONATOMIC_STRONG(NSString,ItemQuantity)	;//	产品数量
_PROPERTY_NONATOMIC_STRONG(NSString,productId)	;//	产品ID
_PROPERTY_NONATOMIC_STRONG(NSString,ItemPromo)	;//	产品优惠价
_PROPERTY_NONATOMIC_STRONG(NSString,smallImageUrl)	;//	图片
_PROPERTY_NONATOMIC_STRONG(NSString,productName)	;//	产品名称
@end
