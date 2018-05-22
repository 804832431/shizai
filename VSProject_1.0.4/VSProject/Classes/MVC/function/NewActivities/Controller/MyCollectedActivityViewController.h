//
//  MyCollectedActivityViewController.h
//  VSProject
//
//  Created by apple on 10/18/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "NewActivityModel.h"
#import "NewActivityListModel.h"

@interface MyCollectedActivityViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist)

@end
