//
//  MyEnrolledActivityViewController.h
//  VSProject
//
//  Created by apple on 10/18/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "NewActivityModel.h"
#import "NewActivityListModel.h"

@interface MyEnrolledActivityViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist_All)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist_NOT_START)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist_STARTED)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist_COMPLETED)

@end
