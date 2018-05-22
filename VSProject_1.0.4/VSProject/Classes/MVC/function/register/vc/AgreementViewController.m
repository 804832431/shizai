//
//  AgreementViewController.m
//  EmperorComing
//
//  Created by certus on 15/9/19.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController (){

    UIWebView *webview;

}

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self vs_setTitleText:_titleName];

    webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    webview.backgroundColor = [UIColor whiteColor];
    webview.delegate = (id<UIWebViewDelegate>)self;
    [self.view addSubview:webview];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:_resourceName ofType:@"html"];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
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
