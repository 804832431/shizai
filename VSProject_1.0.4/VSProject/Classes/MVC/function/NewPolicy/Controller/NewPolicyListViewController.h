//
//  NewPolicyListViewController.h
//  VSProject
//
//  Created by apple on 11/6/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseViewController.h"

@interface NewPolicyListViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist_Current)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist_History)

@end
