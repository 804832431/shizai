//
//  VSJsWebViewController.h
//  VSProject
//
//  Created by XuLiang on 15/11/3.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"

@class JSWebView;

@interface VSJsWebViewController : VSBaseViewController

@property(nonatomic, strong, readonly)JSWebView *webView;

@property(nonatomic, retain)NSURL       *webUrl;        //weburl
@property(nonatomic, strong)NSString    *webTitle;

@property (nonatomic,copy) void (^TriggerFuncCallback)(NSString *func);

- (id)initWithUrl:(NSURL*)url;   //use defaultTitle

- (id)initWithWebTitle:(NSString*)webTitle url:(NSURL*)url;

- (void)setNavBarItems;

- (void)reloadWebView;

- (void)refreshTitle;

- (void)refresh;

- (void)goBack;

- (void)goForward;

- (void)clearCaches;
//
- (void)toOrder:(id)dic;
- (void)toCart:(id)data;
- (void)toProInfo:(id)data;
- (void)toPoint:(id)data;
- (void)toShare:(id)data;
- (void)toCall:(id)data;
- (void)toSubscribe:(id)data;
- (void)toBook:(id)data;
- (void)toApply:(id)data;

- (NSString *)getCartInfo:(NSString *)key;

-(void)recoverRightButton;

- (BOOL)webViewCanGoBack;

@end
