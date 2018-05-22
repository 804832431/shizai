//
//  PolicyListViewController.h
//  VSProject
//
//  Created by certus on 16/4/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"

@interface PolicyListViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist)

@end
