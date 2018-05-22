//
//  HomeViewController.h
//  VSProject
//
//  Created by 姚君 on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"

@interface HomeViewController : VSBaseViewController

- (void)changeLocation;
- (void)changeHome;

- (void)userCenter;
- (void)tojswebview;
- (void)toShakeview;
- (void)customizeHome;
- (BOOL)isUserlogin;

- (void)APPPushToVC:(NSString *)type link:(NSString *)link catalogId:(NSString *)catalogId orderType:(NSString *)orderType;
@end
