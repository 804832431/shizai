//
//  RefundResonTopTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/8/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface RefundResonTopTableViewCell : UITableViewCell

@property (nonatomic,strong) Order *order;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
