//
//  ReceivingAddressViewController.h
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseTableViewController.h"

@interface ReceivingAddressViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(UIButton, addButton)
_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist)

@property(nonatomic,copy)void(^selectReceiveAdress)(AdressModel *adModel);

@end
