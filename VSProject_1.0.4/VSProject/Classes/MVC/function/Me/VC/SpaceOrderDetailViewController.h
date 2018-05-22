//
//  SpaceOrderDetailViewController.h
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import "VSBaseTableViewController.h"


@class Order;

@interface SpaceOrderDetailViewController : VSBaseTableViewController

@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,strong) Order *order;

@end
