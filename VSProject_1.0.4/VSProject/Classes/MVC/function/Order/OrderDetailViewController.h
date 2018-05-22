//
//  OrderDetailViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "VSBaseTableViewController.h"
#import "OrderPastHeaderTableViewCell.h"

@interface OrderDetailViewController : VSBaseTableViewController

@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,strong) Order *order;

@end
