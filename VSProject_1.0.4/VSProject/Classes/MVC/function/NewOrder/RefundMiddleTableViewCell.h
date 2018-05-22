//
//  RefundMiddleTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/2.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "OrderDetailDTO.h"

@interface RefundMiddleTableViewCell : UITableViewCell

@property (nonatomic,strong) OrderDetailDTO *dto;

@property (nonatomic,strong) Order *order;

@property (nonatomic,strong) UILabel *bottomLineView;

@property (nonatomic,strong) UILabel *orderStatusLabel;

@end
