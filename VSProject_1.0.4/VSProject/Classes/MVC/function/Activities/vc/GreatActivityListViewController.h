//
//  GreatActivityListViewController.h
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSBaseViewController.h"

@interface GreatActivityListViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, completeDatalist)
_PROPERTY_NONATOMIC_ASSIGN(BOOL, ifNeedRefresh)
- (void)refresh;

@end
