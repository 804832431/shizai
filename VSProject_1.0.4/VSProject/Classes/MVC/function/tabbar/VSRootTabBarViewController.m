//
//  VSRootTabBarViewController.m
//  VSProject
//
//  Created by tiezhang on 15/2/25.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSRootTabBarViewController.h"
#import "VSNavigationViewController.h"

@interface VSRootTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation VSRootTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)setTabDataSource:(NSArray *)tabDataSource
{
    if(_tabDataSource != tabDataSource)
    {
        _tabDataSource = nil;
        _tabDataSource = tabDataSource;
        
        NSMutableArray *viewControllers = [NSMutableArray array];
        
        for (VSTabBarItemData *item in self.tabDataSource)
        {
            VSNavigationViewController *tabVC = [[VSNavigationViewController alloc]initWithRootViewController:(UIViewController*)item.tabItemViewController];
            
            [tabVC.tabBarItem setTitle:item.tabItemTitle];
            [tabVC.tabBarItem setImage:[UIImage imageNamed:item.tabItemNormalImageName]];
            [tabVC.tabBarItem setSelectedImage:[UIImage imageNamed:item.tabItemSelectedImageName]];
            
            
            [tabVC.tabBarItem setTitleTextAttributes:@{
                                                       NSFontAttributeName:[UIFont systemFontOfSize:10.f],
                                                       NSForegroundColorAttributeName:ColorWithHex(0x898989, 1),
                                                       } forState:UIControlStateNormal];
            
            [tabVC.tabBarItem setTitleTextAttributes:@{
                                                       NSFontAttributeName:[UIFont systemFontOfSize:10.f],
                                                       NSForegroundColorAttributeName:ColorWithHex(0x898989, 1),
                                                       } forState:UIControlStateSelected];
            [viewControllers addObject:tabVC];
        }
        
        [self setViewControllers:viewControllers];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
