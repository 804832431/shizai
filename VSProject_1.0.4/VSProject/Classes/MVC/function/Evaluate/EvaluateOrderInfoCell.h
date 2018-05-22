//
//  EvaluateOrderInfoCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/7/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface EvaluateOrderInfoCell : UITableViewCell

@property (nonatomic,strong) UILabel *orderIdLabel;

@property (nonatomic,strong) UILabel *orderCompanyLabel;

@property (nonatomic,strong) UILabel *orderStateLabel;

@property (nonatomic,strong) UIView *bottomLineView;

@property (nonatomic,strong) Order *order;

@end
