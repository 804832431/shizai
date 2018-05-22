//
//  categoryId categoryName categoryId categoryName Category.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseModel.h"

@interface CategoryDTO : VSBaseModel
_PROPERTY_NONATOMIC_STRONG(NSString, categoryId);    //商户id
_PROPERTY_NONATOMIC_STRONG(NSString, categoryName);//商户名称
_PROPERTY_NONATOMIC_STRONG(NSArray, prodsList);//商品列表

_PROPERTY_NONATOMIC_STRONG(NSString, productStoreId);//商城ID（全局配置常量）
_PROPERTY_NONATOMIC_STRONG(NSString, orderTypeId);//订单类型
_PROPERTY_NONATOMIC_STRONG(NSString, catalogId);//应用id


@end
