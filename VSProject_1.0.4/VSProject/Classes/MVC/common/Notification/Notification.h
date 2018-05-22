//
//  Notification.h
//  EmperorComing
//
//  Created by certus on 15/8/28.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject

//添加本地通知
+ (UILocalNotification *)addLocalNotification:(NSDictionary*)info timeInterval:(NSTimeInterval)interval alertBody:(NSString *)alert;

//移除本地通知
+ (void)removeLocalNotification:(NSDictionary*)info;

//集成极光推送
+ (void)startJPushWithOptions:(NSDictionary *)launchOptions;

//极光打别名
+ (void)setJPushAlias;

//极光打标签
+ (void)setJPushTag;

//极光删别名
+ (void)removeJPushAlias;

//极光删标签
+ (void)removeJPushTag;

@end
