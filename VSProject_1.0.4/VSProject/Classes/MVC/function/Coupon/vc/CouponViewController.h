//
//  CouponViewController.h
//  VSProject
//
//  Created by certus on 16/4/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "CouponModel.h"

@interface CouponViewController : VSBaseViewController

@property (nonatomic,strong)NSString *key;
@property (nonatomic,strong)NSString *orderAmount;
@property (nonatomic,strong)NSString *merchantId;
@property (nonatomic,strong)NSString *titleName;
@property (nonatomic,copy) void (^couponModelBlock)(CouponModel *couponModel);

@end
