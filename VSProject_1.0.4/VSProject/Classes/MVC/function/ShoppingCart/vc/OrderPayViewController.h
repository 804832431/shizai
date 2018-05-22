//
//  OrderPayViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/15.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSBaseViewController.h"


@interface OrderPayViewController : VSBaseViewController

@property (nonatomic,strong) NSString *orderType;

@property (nonatomic,strong) NSString *orderId;//订单id

@property (nonatomic,strong) NSString *needPayMoeny;//需要支付金额

@end
