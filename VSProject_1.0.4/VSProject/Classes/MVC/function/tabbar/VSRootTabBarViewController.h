//
//  VSRootTabBarViewController.h
//  VSProject
//
//  Created by tiezhang on 15/2/25.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTabBarController.h"
#import "VSTabBarItemData.h"

@interface VSRootTabBarViewController : VSBaseTabBarController

//tab数据源
_PROPERTY_NONATOMIC_STRONG(NSArray, __dataitem_typeof__(VSTabBarItemData) tabDataSource);

@end
