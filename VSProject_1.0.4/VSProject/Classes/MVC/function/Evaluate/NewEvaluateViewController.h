//
//  NewEvaluateViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 16/7/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "Order.h"

@interface NewEvaluateViewController : VSBaseViewController

@property (nonatomic,strong)Order *order;

@property (nonatomic,copy) void (^evaluateBlock)(void);

@end
