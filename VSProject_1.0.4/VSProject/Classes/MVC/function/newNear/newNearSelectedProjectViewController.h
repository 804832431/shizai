//
//  newNearSelectedProjectViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 16/8/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "Project.h"

@interface newNearSelectedProjectViewController : VSBaseViewController

@property (nonatomic,copy) void (^callBackBlock)(Project *pro);

- (void)refresh;

@end
