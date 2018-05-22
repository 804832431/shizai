//
//  OrderHeader.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderHeader : VSBaseModel

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,createBy);//	创建人
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,grandTotal);//	总价
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,orderDate);//	创建时间
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,orderId);//	订单id
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,orderStatus);//	订单状态
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,orderTypeId);//	订单类型
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,remainingSubTotal);//	除去邮费外的价格
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,reservationDate);//	预约时间
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,storeId);//	商户id
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,storeName);//	商户名称
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,remark);//	备注
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,isCanRate);//是否可以进行评论
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,isCanRefund);//是否能退款

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,refundAmount);//退款金额
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,paymentType);//支付方式，EXT_ALIPAY：支付宝， EXT_WECHATPAY：微信
@end
