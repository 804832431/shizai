//
//  MessageContentViewController.m
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MessageContentViewController.h"
#import "MessageManager.h"

@interface MessageContentViewController () {

    MessageManager *manger;

}

@end

@implementation MessageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.navigationController) {
        [self vs_setTitleText:@"消息详情"];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"deliveryAddress_barrel"] style:UIBarButtonItemStylePlain target:self action:@selector(actionDeleteMessage)];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }else {
    
        UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 64)];
        UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@""];
        
        UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        [customLab setTextColor:[UIColor whiteColor]];
        customLab.textAlignment = NSTextAlignmentCenter;
        [customLab setText:@"消息详情"];
        navigationItem.titleView = customLab;
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(removePush)];
        navBar.tintColor = [UIColor whiteColor];
        [navBar pushNavigationItem:navigationItem animated:NO];
        [navigationItem setLeftBarButtonItem:leftItem];
        navBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nav_green"]];
        [self.view addSubview:navBar];
    }

    [self vs_showRightButton:YES];
    
    [self.vm_rightButton setImage:__IMAGENAMED__(@"deliveryAddress_barrel") forState:UIControlStateNormal];
    
    [self.vm_rightButton setImage:__IMAGENAMED__(@"deliveryAddress_barrel") forState:UIControlStateHighlighted];
    
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = (id<UIWebViewDelegate>)self;
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];

    [_webView setFrame:CGRectMake(0, -64, __SCREEN_WIDTH__, __SCREEN_HEIGHT__)];
    manger = [[MessageManager alloc]init];
    [self requestMessageContent];

}

- (void)removePush  {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)vs_rightButtonAction:(id)sender {
    [self deleteMessage];
}

#pragma mark -- request

- (void)deleteMessage {
    
    [self vs_showLoading];
    NSDictionary *para = @{@"messageId":_m_model.id?:@""};
    [manger requestDeleteMessage:para success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self vs_back];
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}

- (void)requestMessageContent {
    
    [self vs_showLoading];
    NSDictionary *para = @{@"messageId":_m_model.id?:@""};
    [manger requestMessageContent:para success:^(NSDictionary *responseObj) {
        _m_model.isRead = @"Y";
        //
        NSLog(@"responseObj--%@",responseObj);
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self loadContent:[responseObj objectForKey:@"message"]];
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 50 && buttonIndex == 1) {
        
        [self deleteMessage];
        
    }
    
}

- (void)actionDeleteMessage {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要删除此条消息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 50;
    [alert show];
    
}

#pragma mark -- private

- (void)loadContent:(NSDictionary *)dic {
    
    NSString *createTime = [dic objectForKey:@"createTime"];
    NSString *message = [dic objectForKey:@"message"];
    NSString *time = [NSDate timeSeconds:createTime.longLongValue];

    NSString *html = [NSString stringWithFormat:@"<html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width; initial-scale=1.0; maximum-scale=1.0;'></head><body><div padding-left:17px;padding-top:10px;padding-right:17px><p align='right'><font style='font-family:Helvetica;font-size:13px;color:#808080'>%@</font></p><p align='left'><font style='font-family:Helvetica;font-size:13px;color:#666666;line-height:20px'>%@</font></p></div></body></html>",time,message];

    [_webView loadHTMLString:html baseURL:nil];
    [_webView setFrame:CGRectMake(0, -64, __SCREEN_WIDTH__, __SCREEN_HEIGHT__)];
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
