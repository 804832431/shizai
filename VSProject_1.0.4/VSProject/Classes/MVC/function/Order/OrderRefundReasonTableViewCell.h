//
//  OrderRefundReasonTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/12/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderRefundReasonTableViewCell : UITableViewCell

@property (nonatomic,strong) Order *order;


@property (nonatomic,strong) UILabel *refundResonName;

@property (nonatomic,strong) UILabel *refundResonValue;

@property (nonatomic,strong) UILabel *bottomLineView;

@property (nonatomic,strong) UILabel *TopLineView;

@end
