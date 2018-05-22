//
//  OrderPastHeaderTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderPastHeaderTableViewCell : UITableViewCell

@property (nonatomic,strong) Order *order;

@property (nonatomic,strong) UILabel *bottomLineView;

@property (nonatomic,strong) UILabel *middleLineView;

@property (nonatomic,strong) UILabel *topLineView;

@property (nonatomic,strong) UILabel *orderPastHeaderContent;

@property (nonatomic,strong) UILabel *orderPastHeaderCompanyContent;

@property (nonatomic,strong) UILabel *orderPastHeaderPostIdContent;

@property (nonatomic,strong) UILabel *orderPastHeaderPostIdContentValue;

@end
