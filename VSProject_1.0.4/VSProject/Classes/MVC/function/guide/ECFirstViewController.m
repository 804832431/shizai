//
//  ECFirstViewController.m
//  EmperorComing
//
//  Created by XuLiang on 15/10/10.
//  Copyright (c) 2015年 姚君. All rights reserved.
//

#import "ECFirstViewController.h"

@interface ECFirstViewController ()

@end

@implementation ECFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showIntroWithCustomView];
}
- (void)showIntroWithCustomView {
    self.navigationController.navigationBarHidden=YES;
    //    self.navigationController.tabBarController.tabBar.hidden = YES;
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds];
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
    intro.pageControlY = 1;
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"guide1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"guide2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guide3"];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:@"guide4"];
    
    
    
    
    [intro setPages:@[page1,page2,page3,page4]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setFrame:CGRectMake((MainWidth)*0.25, MainHeight - MainHeight*107/669-60, (MainWidth)*0.5, 60)];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(introDidFinish) forControlEvents:UIControlEventTouchUpInside];
    intro.skipButton = btn;
    btn.backgroundColor = [UIColor clearColor];
    intro.skipButton.hidden = YES;
    [self.view addSubview:btn];
    
}
- (void)introDidFinish {
    NSLog(@"Intro callback");
    self.navigationController.navigationBarHidden=NO;
    
    if (_nextRoot) {
        NSUserDefaults *loginDefaults = [NSUserDefaults standardUserDefaults];
        [loginDefaults setObject:@"NO" forKey:@"isFirst"];
        [loginDefaults synchronize];
        AppDelegate  *appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController=_nextRoot;
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
