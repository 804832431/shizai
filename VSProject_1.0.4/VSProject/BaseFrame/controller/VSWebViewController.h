//
//  VSWebViewController.h
//  VSProject
//
//  Created by user on 15/1/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"

@protocol VMBaseWebViewViewControllerProtocol <NSObject>

@optional
- (void)handleShouldStartLoadWithRequest:(NSURLRequest *)request;

- (void)handleFailLoadWithError:(NSError *)error;

- (void)handleDidFinishLoad;

@end

@interface VSWebViewController : VSBaseViewController<UIWebViewDelegate, VMBaseWebViewViewControllerProtocol>

@property(nonatomic, strong, readonly)UIWebView *webView;
@property(nonatomic, retain)NSURL       *webUrl;        //weburl
@property(nonatomic, assign)BOOL        showToolBar;    //default is YES
@property(nonatomic, strong)NSString    *webTitle;


- (id)initWithUrl:(NSURL*)url;   //use defaultTitle

- (id)initWithWebTitle:(NSString*)webTitle url:(NSURL*)url;

- (void)reloadWebView;

- (void)refreshTitle;

- (void)refresh;

- (void)goBack;

- (void)goForward;

- (void)clearCaches;

@end
