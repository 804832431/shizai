//
//  AppDelegate.h
//  VSProject
//
//  Created by user on 15/1/10.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

#define _GET_APP_DELEGATE_(appDelegate)\
AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow      *window;
@property (strong, nonatomic) UITabBarController *tb;

@end

