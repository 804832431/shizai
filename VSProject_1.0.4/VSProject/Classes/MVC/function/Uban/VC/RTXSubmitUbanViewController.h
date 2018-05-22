//
//  RTXSubmitUbanViewController.h
//  VSProject
//
//  Created by certus on 16/4/3.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"

#define rowSection0     3
#define rowSection1     5
#define rowSection2     4

typedef enum : NSUInteger {
    RENTFREE_NONE = 0,
    RENTFREE_HALFMONTH,
    RENTFREE_ONEMONTH,
} RENTFREE_PREID;

typedef enum : NSUInteger {
    PAYM_NONE = 0,
    PAYM_1FU1,
    PAYM_1FU3,
    PAYM_1FU6,
    PAYM_3FU1,
    PAYM_3FU3,
    PAYM_3FU6,
    PAYM_3FUN,
    PAYM_2FU3,
    PAYM_2FU6
} PAY_MENTH;

@interface RTXSubmitUbanViewController : VSBaseViewController

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic,strong) NSMutableArray *rightArray;

- (void)rejuestDatasources;

@end
