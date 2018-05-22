//
//  HomeBTabbarViewController.h
//  VSProject
//
//  Created by certus on 16/3/8.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"

@interface HomeBTabbarViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(UITabBarController, tb);

- (void)pushToB;
+ (HomeBTabbarViewController*)shareInstance;

@end
