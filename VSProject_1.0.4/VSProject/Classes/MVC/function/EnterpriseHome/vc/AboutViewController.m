//
//  AboutViewController.m
//  EmperorComing
//
//  Created by certus on 15/8/31.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *Lblversion;
@property (weak, nonatomic) IBOutlet UILabel *LblcopyRight;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self vs_setTitleText:@"当前版本"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [self.Lblversion setText:[NSString stringWithFormat:@"时在 V%@",app_Version]];
    
    self.LblcopyRight.text = @"睿天下 版权所有\nCopyright©2015 All Rights Reserved";
    self.LblcopyRight.numberOfLines = 0;//表示label可以多行显示
    
    self.LblcopyRight.lineBreakMode = NSLineBreakByWordWrapping;//换行模式，与上面的计算保持一致。
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack {

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
