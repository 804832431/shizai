//
//  HomeViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 16/7/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSBaseViewController.h"

@interface BHomeViewController : VSBaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;


@end
