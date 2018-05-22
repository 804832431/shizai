//
//  RefundViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 16/8/3.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "Order.h"

@interface RefundViewController : VSBaseViewController

@property (nonatomic,assign) NSInteger index;//选中segmentView index

@property (nonatomic,strong) Order *cancelOrder;

@end
