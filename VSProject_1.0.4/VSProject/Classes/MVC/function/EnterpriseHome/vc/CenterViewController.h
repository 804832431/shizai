//
//  CenterViewController.h
//  VSProject
//
//  Created by certus on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"

typedef NS_ENUM(long,CENTER_BACK) {
    
    CENTER_BACK_HOME = 0,
    CENTER_BACK_DEFAULT
};

@interface CenterViewController : VSBaseViewController

@property (nonatomic,copy) NSString *className;
@property (nonatomic,assign) CENTER_BACK backWhere;

@end
