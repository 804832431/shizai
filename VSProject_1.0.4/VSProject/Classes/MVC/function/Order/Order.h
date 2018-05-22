//
//  Order.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderProduct.h"
#import "OrderHeader.h"
#import "OrderPostAddress.h"

@interface Order : VSBaseModel

_PROPERTY_NONATOMIC_STRONG(NSMutableArray,orderProductList);

_PROPERTY_NONATOMIC_STRONG(OrderHeader,orderHeader);

_PROPERTY_NONATOMIC_STRONG(OrderPostAddress,postAddress);



_PROPERTY_NONATOMIC_STRONG(NSString,trackingNum);//	快递单号
_PROPERTY_NONATOMIC_STRONG(NSString,expressCompany);//	快递公司
_PROPERTY_NONATOMIC_STRONG(NSString,createDate);//	下单时间
_PROPERTY_NONATOMIC_STRONG(NSString,sentDate);//	发货时间（未发货，该值为空）
_PROPERTY_NONATOMIC_STRONG(NSString,completedDate);//	收货时间（未收货，该值为空）
_PROPERTY_NONATOMIC_STRONG(NSString,returnReason);//	退货理由(未申请退货，该值为空)
_PROPERTY_NONATOMIC_STRONG(NSString,orderStatusList);//	订单状态列表(只提供给后端使用)
_PROPERTY_NONATOMIC_STRONG(NSString,orderAdjustmentList);//	订单调整列表(只提供给后端使用)
_PROPERTY_NONATOMIC_STRONG(NSString,orderSubTotal);//	订单总额优惠前(商品未打折,不含运费,只提供给后端使用)
_PROPERTY_NONATOMIC_STRONG(NSString,orderShippingTotal);//	运费(只提供给后端使用)
_PROPERTY_NONATOMIC_STRONG(NSString,discountAmount);//	订单优惠额
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,payDate);//	支付日期

@end
