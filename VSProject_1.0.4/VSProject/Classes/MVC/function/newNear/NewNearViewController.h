//
//  NewNearViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 16/7/28.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "Project.h"



@interface NewNearViewController : VSBaseViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) Project *targetproject;


@end
