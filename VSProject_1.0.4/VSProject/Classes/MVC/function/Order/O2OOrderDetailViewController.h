//
//  O2OOrderDetailViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSBaseTableViewController.h"
#import "Order.h"


@interface O2OOrderDetailViewController : VSBaseTableViewController

@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,strong) Order *order;


@end
