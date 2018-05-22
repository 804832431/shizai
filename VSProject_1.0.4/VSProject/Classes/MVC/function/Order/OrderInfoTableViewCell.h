//
//  OrderInfoTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderInfoTableViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic,strong) Order *order;

@property (nonatomic,strong) UILabel *topLineView;

@property (nonatomic,strong) UILabel *bottomLineView;

@property (nonatomic,strong) UILabel *middleLineView;

@property (nonatomic,strong) UILabel *orderTime;

@property (nonatomic,strong) UILabel *orderPastTime;//预约或配送时间

@property (nonatomic,strong) UILabel *orderId;

@property (nonatomic,strong) UILabel *orderStatus;

@property (nonatomic,strong) UILabel *orderMoney;

@property (nonatomic,strong) UILabel *orderSale;

@property (nonatomic,strong) UILabel *orderPastMoney;

@property (nonatomic,strong) UILabel *orderDiscountAmount;

@property (nonatomic,strong) UITextView *messageTextView;

@property (nonatomic,strong) UILabel *remarkTitleLabel;


@end
