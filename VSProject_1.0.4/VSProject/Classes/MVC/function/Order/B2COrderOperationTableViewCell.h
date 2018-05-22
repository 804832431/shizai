//
//  B2COrderOperationTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface B2COrderOperationTableViewCell : UITableViewCell


@property (nonatomic,copy) void (^cancelOrder)(Order *order);//取消订单

@property (nonatomic,copy) void (^payOrder)(Order *order);//支付订单

@property (nonatomic,copy) void (^confirmReceiptOrder)(Order *order);//确认收货

@property (nonatomic,copy) void (^refundRrder)(Order *order);//申请退款

@property (nonatomic,copy) void (^showPostInfo)(Order *order);//查看物流


@property (nonatomic,strong) Order *order;

@property (nonatomic,strong) UILabel *sepLineView;//分割线

@property (nonatomic,strong) UILabel *orderNeedMoney;//订单实付金额

@property (nonatomic,strong) UILabel *orderNeedMoneyTitle;//订单实付金额提示

@property (nonatomic,strong) UILabel *orderStatus;//订单状态

@property (nonatomic,strong) UIButton *oneButton;//订单操作按钮

@property (nonatomic,strong) UIButton *twoButton;//订单操作按钮

@property (nonatomic,strong) UIButton *threeButton;//订单操作按钮

@property (nonatomic,strong) UILabel *bottomLineView;//底部分割线

@end
