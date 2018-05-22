//
//  SpaceLeaseViewController.h
//  VSProject
//
//  Created by pangchao on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import "VSBaseViewController.h"

typedef void(^LoadDataSuccessBlock)();

@interface SpaceLeaseViewController : VSBaseViewController

@property (nonatomic, copy) NSString *classId;

@property (nonatomic, strong) LoadDataSuccessBlock loadDataSuccessBolck;

- (void)refresh;

- (CGFloat)getViewHeight;

@end
