//
//  MyAppliedPolicyViewController.h
//  VSProject
//
//  Created by apple on 11/7/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseViewController.h"

@interface MyAppliedPolicyViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist_All)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist_Opened)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist_NotOpened)

@end
