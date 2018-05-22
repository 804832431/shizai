//
//  RTXUnionPayWebViewController.m
//  VSProject
//
//  Created by XuLiang on 16/1/28.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXUnionPayWebViewController.h"

@interface RTXUnionPayWebViewController ()
{
    UIWebView *_webView;
}
@end

@implementation RTXUnionPayWebViewController
@synthesize htmlStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!_webView)
    {
        [self.view addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.view);
            
        }];
    }
    [self refreshTitle];
    self.webView.delegate = self;
    [self reloadWebView];
}
/**
 *  加载Webview
 */
- (void)reloadWebView
{
    [self.webView loadHTMLString:htmlStr baseURL:nil];
}
/**
 *  刷新网页Title
 */
- (void)refreshTitle
{
    NSString *theTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    [self vs_setTitleText:(theTitle.length > 0)? theTitle : @" "];
}

#pragma mark -- UIWebviewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self vs_showLoading];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self refreshTitle];
    [self vs_hideLoadingWithCompleteBlock:nil];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view showTipsView:[error domain]];
    [self vs_hideLoadingWithCompleteBlock:nil];
}
#pragma mark -- getter
_GETTER_ALLOC_BEGIN(UIWebView, webView)
{
    _webView.clipsToBounds   = YES;
    _webView.scalesPageToFit = YES;
    //_webView.scrollView.delegate = self;
    
}
_GETTER_END(webView)
@end
