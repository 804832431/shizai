//
//  ProductDTO.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseModel.h"

@interface ProductDTO : VSBaseModel

_PROPERTY_NONATOMIC_STRONG(NSString,productId)	;//产品id
_PROPERTY_NONATOMIC_STRONG(NSString,productName)	;//商品名称
_PROPERTY_NONATOMIC_STRONG(NSString,productTypeId)	;//商品类型（不需要展示）
_PROPERTY_NONATOMIC_STRONG(NSString,quantity)	;//商品数量（库存够的话返回传入的数量，否则返回剩下的库存的值）
_PROPERTY_NONATOMIC_STRONG(NSString,smallImageUrl)	;//图片地址(相对路径)
_PROPERTY_NONATOMIC_STRONG(NSString,unitPrice)	;//商品价格

_PROPERTY_NONATOMIC_STRONG(NSString,productAttribute);//商品规格


@end
