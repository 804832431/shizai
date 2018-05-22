//
//  RTXUnionPayWebViewController.h
//  VSProject
//
//  Created by XuLiang on 16/1/28.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"

@interface RTXUnionPayWebViewController : VSBaseViewController<UIWebViewDelegate>
/**
 *  网页字符串
 */
@property(nonatomic, strong)NSString *htmlStr;
/**
 *  网页
 */
@property(nonatomic, strong, readonly)UIWebView *webView;

@end
