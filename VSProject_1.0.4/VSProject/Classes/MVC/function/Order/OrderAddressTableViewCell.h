//
//  OrderAddressTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderAddressTableViewCell : UITableViewCell

@property (nonatomic,strong) Order *order;

@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) UIImageView *contactImageView;

@property (nonatomic,strong) UILabel *contactNameLabel;

@property (nonatomic,strong) UIImageView *phoneImageView;

@property (nonatomic,strong) UILabel *phoneLabel;

@property (nonatomic,strong) UILabel *addressLabel;

@property (nonatomic,strong) UIImageView *addressImageView;

@property (nonatomic,strong) UILabel *contactName;

@property (nonatomic,strong) UILabel *addressName;

@property (nonatomic,strong) NSString *orderTypeId;//订单类型

@end
