//
//  VSUIManager.m
//  VSProject
//
//  Created by tiezhang on 15/10/12.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUIManager.h"
#import "VSZixunDetailViewController.h"
#import "VSNavigationViewController.h"

@interface VSUIManager ()

@property(nonatomic, strong)VSNavigationViewController *testNav;

@end

@implementation VSUIManager

DECLARE_SINGLETON(VSUIManager)


- (instancetype)init
{
    self = [super init];
    if (self) {
        _GET_APP_DELEGATE_(appDelegate);
        UITabBarController *tabVC = (UITabBarController*)appDelegate.window.rootViewController;
        self.testNav = (VSNavigationViewController*)tabVC.selectedViewController;
    }
    return self;
}

- (void)vs_pushToZiXunDetail:(NSString*)url
{
    VSZixunDetailViewController *zxVC = [[VSZixunDetailViewController alloc]initWithUrl:[NSURL URLWithString:url]];
    [self.testNav pushViewController:zxVC animated:YES];
}

@end
