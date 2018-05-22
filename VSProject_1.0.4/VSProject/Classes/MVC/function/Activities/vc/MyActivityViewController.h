//
//  MyActivityViewController.h
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSBaseViewController.h"

typedef enum : NSUInteger {
    BACK_DEFAULT,
    BACK_ROOT,
}MYACTIVITY_BACK;


@interface MyActivityViewController : VSBaseViewController

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(NSMutableArray, datalist)
@property (nonatomic,assign)MYACTIVITY_BACK backwhere;

@end
