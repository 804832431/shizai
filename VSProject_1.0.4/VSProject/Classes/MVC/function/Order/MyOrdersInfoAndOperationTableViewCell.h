//
//  MyOrdersInfoAndOperationTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/22.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface MyOrdersInfoAndOperationTableViewCell : UITableViewCell

@property (nonatomic,copy) void (^readyPayOrder)(Order *order);//买单

@property (nonatomic,copy) void (^cancelAppointment)(Order *order);//取消预约

@property (nonatomic,copy) void (^cancelOrder)(Order *order);//取消订单

@property (nonatomic,copy) void (^payOrder)(Order *order);//支付订单

@property (nonatomic,copy) void (^confirmReceiptOrder)(Order *order);//确认收货

@property (nonatomic,copy) void (^refundRrder)(Order *order);//申请退款

@property (nonatomic,copy) void (^showPostInfo)(Order *order);//查看物流

@property (nonatomic,copy) void (^evaluateOrder)(Order *order);//去评论


@property (nonatomic,strong) Order *order;

@property (nonatomic,strong) UILabel *bottomLineView;

@property (nonatomic,strong) UILabel *totalMoney;

@property (nonatomic,strong) UIButton *oneButton;

@property (nonatomic,strong) UIButton *twoButton;

@property (nonatomic,strong) UIButton *threeButton;

@property (nonatomic,strong) UIView *sepBottomView;

@end
