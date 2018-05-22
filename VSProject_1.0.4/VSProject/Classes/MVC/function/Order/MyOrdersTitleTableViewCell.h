//
//  MyOrderTitleTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/22.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface MyOrdersTitleTableViewCell : UITableViewCell

@property (nonatomic,strong) Order *order;

@property (nonatomic,strong) UILabel *topLineView;

@property (nonatomic,strong) UILabel *bottomLineView;

@property (nonatomic,strong) UILabel *orderId;

@property (nonatomic,strong) UILabel *orderStatus;

@end
