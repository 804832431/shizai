//
//  JSWebView.h
//  VSProject
//
//  Created by XuLiang on 15/11/3.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JavaScriptBridge.h"

@interface JSWebView : UIWebView
@property (nonatomic, retain) JavaScriptBridge *javaScriptBridge;
/**
 *  注册JavaScript接口
 *
 *  @param interface 接口实例
 *  @param name      接口名称
 */
- (void)addJavascriptInterface:(NSObject *)interface withName:(NSString *)name;
@end
