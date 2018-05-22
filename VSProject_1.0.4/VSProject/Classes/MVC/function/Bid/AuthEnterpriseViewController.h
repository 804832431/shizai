//
//  AuthEnterpriseViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "Bidder.h"

@interface AuthEnterpriseViewController : VSBaseViewController

- (void)setDataSource:(Bidder *)bidder;

@property (nonatomic, assign) BOOL isModify;

@end
