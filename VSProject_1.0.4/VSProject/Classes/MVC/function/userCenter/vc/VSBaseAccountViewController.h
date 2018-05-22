//
//  VSBaseAccountViewController.h
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTableViewController.h"
#import "VSAccountBtnActionCell.h"
#import "VSAccountInfoCell.h"
#import "VSBaseUserAccountParm.h"

typedef enum _ACCOUNT_SUBMIT_TYPE
{
    ACCOUNT_SUBMIT_LOGIN,
    ACCOUNT_SUBMIT_REGISTER,
}ACCOUNT_SUBMIT_TYPE;

@interface VSBaseAccountViewController : VSBaseTableViewController

_PROPERTY_NONATOMIC_ASSIGN(ACCOUNT_SUBMIT_TYPE, vm_submitType);

_PROPERTY_NONATOMIC_STRONG(VSBaseUserAccountParm, vm_submitParm);

@end
