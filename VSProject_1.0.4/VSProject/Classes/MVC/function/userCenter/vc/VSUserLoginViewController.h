//
//  VSUserLoginViewController.h
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseAccountViewController.h"

typedef void(^SucceedBlock)();
typedef void(^CancelBlock)();

@interface VSUserLoginViewController : VSBaseAccountViewController

_PROPERTY_NONATOMIC_ASSIGN(LOGIN_BACK, backWhere)

@property (nonatomic, strong) SucceedBlock succeedBlock;
@property (nonatomic, strong) CancelBlock cancelBlock;

@end
