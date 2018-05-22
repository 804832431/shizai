//
//  BuyOrderViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 16/8/3.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "Order.h"


typedef NS_ENUM(NSUInteger, kMyOrdersViewControllerType) {
    kOrderStatusAll,//全部订单
    kOrderStatusPaymentsDue,//待付款
    kOrderStatusPostGoodsDue,//待发货
    kOrderStatusReceiveGoodsDue,//待收货
    kOrderStatusRefundDue//待退款
};


@interface BuyOrderViewController : VSBaseViewController

@property (nonatomic,assign) kMyOrdersViewControllerType orderType;

@property (nonatomic,assign) NSInteger index;//选中segmentView index

@property (nonatomic,strong) Order *cancelOrder;

@end
