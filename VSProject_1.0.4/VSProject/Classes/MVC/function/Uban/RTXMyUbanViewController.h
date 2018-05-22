//
//  RTXMyUbanViewController.h
//  VSProject
//
//  Created by XuLiang on 16/1/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseTableViewController.h"
@class Order;
@class RTXMyUbanViewController;
@protocol RTXMyUbanViewControllerDelegate <NSObject>

- (void)refreshRedPoint;

@end


@interface RTXMyUbanViewController : VSBaseTableViewController

@property (nonatomic,strong) Order *order;
@property (nonatomic, strong)UINavigationController *nav;
@property (nonatomic, assign)id<RTXMyUbanViewControllerDelegate> delegate;

- (void)refresh;

@end
