//
//  MuSpaceOrderInfoTableViewCell.h
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Order;

@interface MuSpaceOrderInfoTableViewCell : UITableViewCell

@property (nonatomic,strong) Order *order;

@property (nonatomic,strong) UILabel *topLineView;

@property (nonatomic,strong) UILabel *bottomLineView;

@property (nonatomic,strong) UILabel *middleLineView;

@property (nonatomic,strong) UILabel *orderTime;

@property (nonatomic,strong) UILabel *orderId;

@property (nonatomic,strong) UILabel *orderSale;

@property (nonatomic, strong) UILabel *remarkLabel;

@property (nonatomic, strong) UITextView *remarkValueLabel;

@end
