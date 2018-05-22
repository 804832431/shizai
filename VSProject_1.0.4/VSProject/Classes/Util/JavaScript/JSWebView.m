//
//  JSWebView.m
//  VSProject
//
//  Created by XuLiang on 15/11/3.
//  Copyright © 2015年 user. All rights reserved.
//

#import "JSWebView.h"

@implementation JSWebView

- (void) dealloc
{
    [_javaScriptBridge release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initJavaScriptBridge];
    }
    return self;
}
- (id)init
{
    if (self = [super init])
    {
        [self initJavaScriptBridge];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initJavaScriptBridge];
    }
    return self;
}
- (void)initJavaScriptBridge
{
    _javaScriptBridge = [[JavaScriptBridge alloc] init];
    self.delegate = _javaScriptBridge;
}

/**
 *  注册JavaScript接口
 *
 *  @param interface 接口实例
 *  @param name      接口名称
 */
- (void)addJavascriptInterface:(NSObject *)interface withName:(NSString *)name
{
    [_javaScriptBridge addJavascriptInterface:interface withName:name];
}
@end
