//
//  VSLocalNotificationManager.h
//  VSProject
//
//  Created by user on 15/1/19.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseNotificationManager.h"

#define klocalnotification_title        @"vs_wm_location_title"         //选填项-default(@"确定")
#define klocalnotification_content      @"vs_wm_location_content"       //必填项
#define klocalnotification_mapkey       @"vs_wm_location_mapkey"
#define klocalnotification_data         @"vs_wm_location_data"

@interface VSLocalNotificationManager : VSBaseNotificationManager

+ (VSLocalNotificationManager *)shareInstance;

/**
 @brief 清除通知
 */
- (void)removeNotification:(UILocalNotification *)localNotification;

/**
 *  创建一个本地通知
 *
 *  @param key      通知对应的key和该本地通知一一对应
 *  @param date     发起通知的时间
 *  @param userInfo 通知的userInfo(@{localNotification_title:@"xxx", localNotification_content:@"xxx", localNotification_data:@"xxx"})
 *
 *  @return 返回一个创建好的本地通知
 */
- (UILocalNotification *)createNotificationWithKey:(NSString *)key fireDate:(NSDate *)date userInfo:(NSDictionary *)userInfo;

/**
 *  部署一个本地通知
 *
 *  @param localNotification 本地通知
 */
- (void)scheduleLocalNotification:(UILocalNotification *)localNotification;

/**
 *  纠正本地通知的响应时间
 *
 *  @param key   本地通知对应的key
 *  @param timer 距离目前还有多长时间发起通知
 */
- (BOOL)correctNotification:(NSString *)key notificationTime:(NSInteger)time;

/**
 *  纠正本地通知的响应时间
 *
 *  @param key  本地通知对应的key
 *  @param date 新的本地通知响应的通知
 */
- (BOOL)correctNotification:(NSString *)key notificationDate:(NSDate *)date;

/**
 *  删除本地通知
 *
 *  @param key 通知对应的key
 */
- (void)removeLocalNotificationWithKey:(NSString *)key;

/**
 *  根据制定的key获取对应的本地通知
 *
 *  @param key 本地通知的key
 */
- (UILocalNotification *)getLocalNotification:(NSString *)key;

/**
 @brief 取消所有通知
 */
- (void)removeAllNotifications;


@end
