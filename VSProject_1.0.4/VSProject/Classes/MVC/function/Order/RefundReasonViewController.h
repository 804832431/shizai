//
//  RefundReasonViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/26.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSBaseViewController.h"
#import "Order.h"

@interface RefundReasonViewController : VSBaseViewController

@property (nonatomic,strong) Order *order;

@property (nonatomic,copy) void (^RefundBlock)(BOOL isSuccess);



@end
