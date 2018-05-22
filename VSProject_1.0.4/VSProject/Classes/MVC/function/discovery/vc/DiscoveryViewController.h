//
//  DiscoveryViewController.h
//  VSProject
//
//  Created by certus on 16/3/7.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"

typedef enum : NSUInteger {
    DISCOVERY_SHARK = 0,
    DISCOVERY_AROUNND
} DISCOVERY_COLUMN;

@interface DiscoveryViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(NSArray, datalist)

@end
