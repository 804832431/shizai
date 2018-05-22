//
//  AppointmentOrderViewController.h
//  VSProject
//
//  Created by pch_tiger on 17/1/2.
//  Copyright © 2017年 user. All rights reserved.
//

#import "VSBaseViewController.h"

@class Order;

@interface AppointmentOrderViewController : VSBaseViewController

@property (nonatomic,assign) NSInteger index;//选中segmentView index

@property (nonatomic,strong) Order *order;

@end
