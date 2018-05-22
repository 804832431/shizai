//
//  VSLocalNotificationManager.m
//  VSProject
//
//  Created by user on 15/1/19.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSLocalNotificationManager.h"



@interface VSLocalNotificationManager ()

@property(nonatomic, strong) NSMutableDictionary *dicTypeAndLocalNotification;


@end

@implementation VSLocalNotificationManager

DECLARE_SINGLETON(VSLocalNotificationManager)

- (id)init
{
    if (self = [super init])
    {
        _dicTypeAndLocalNotification = [[NSMutableDictionary alloc] init];
        NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
        if (localNotifications.count > 0)
        {
            for (UILocalNotification *notify in localNotifications)
            {
                NSDictionary *userInfo = notify.userInfo;
                NSString *localNotificationKey = userInfo[klocalnotification_mapkey];
                if (localNotificationKey.length > 0)
                {
                    [_dicTypeAndLocalNotification setObject:notify forKey:userInfo[klocalnotification_mapkey]];
                }
            }
        }
    }
    return self;
}

/*
 清除通知
 */
- (void)removeNotification:(UILocalNotification *)localNotifivation{
    NSInteger count =[[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    if(count>0)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:localNotifivation];
        //从内存中删除
        NSDictionary *userInfo = localNotifivation.userInfo;
        NSString *key = userInfo[klocalnotification_mapkey];
        [self removeLocalNotificationWithKey:key];
    }
}

- (void)removeAllNotifications{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [_dicTypeAndLocalNotification removeAllObjects];
}

- (UILocalNotification *)createNotificationWithKey:(NSString *)key fireDate:(NSDate *)date userInfo:(NSDictionary *)userInfo
{
    [self removeLocalNotificationWithKey:key];
    NSDate *now = [NSDate date];
    if ([date earlierDate:now])
    {
        return nil;
    }
    
    UILocalNotification *notificationNotify = [[UILocalNotification alloc] init];
    if (notificationNotify) {
        notificationNotify.fireDate     = date;
        notificationNotify.timeZone     = [NSTimeZone defaultTimeZone];
        notificationNotify.alertBody    = userInfo[klocalnotification_content];
        notificationNotify.soundName    = UILocalNotificationDefaultSoundName;
        notificationNotify.alertAction  = (userInfo[klocalnotification_title]) ? userInfo[klocalnotification_title] : @"确定";
        notificationNotify.applicationIconBadgeNumber = 1;
        NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
        [mutableDic setObject:key forKey:klocalnotification_mapkey];
        notificationNotify.userInfo     = mutableDic;
    }
    
    [_dicTypeAndLocalNotification setObject:notificationNotify forKey:key];
    return notificationNotify;
}

- (void)scheduleLocalNotification:(UILocalNotification *)localNotification
{
    if (localNotification)
    {
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        [UIApplication sharedApplication].applicationIconBadgeNumber ++;
        
        NSDictionary *userInfo  = localNotification.userInfo;
        NSString *mapKey        = userInfo[klocalnotification_mapkey];
        [_dicTypeAndLocalNotification setObject:localNotification forKey:mapKey];
    }
}

- (BOOL)correctNotification:(NSString *)key notificationTime:(NSInteger)time
{
    UILocalNotification *localNotification = _dicTypeAndLocalNotification[key];
    
    NSDate *now = [NSDate date];
    if (localNotification)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        if (time > 0)
        {
            localNotification.fireDate = [now dateByAddingTimeInterval:time];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            return YES;
        }
    }
    return NO;
}

- (BOOL)correctNotification:(NSString *)key notificationDate:(NSDate *)date
{
    NSTimeInterval time = date.timeIntervalSinceNow;
    return [self correctNotification:key notificationTime:time];
}

- (void)removeLocalNotificationWithKey:(NSString *)key
{
    UILocalNotification *localNotification = _dicTypeAndLocalNotification[key];
    if (localNotification)
    {
        [self removeNotification:localNotification];
        [_dicTypeAndLocalNotification removeObjectForKey:key];
        [UIApplication sharedApplication].applicationIconBadgeNumber --;
    }
}

- (UILocalNotification *)getLocalNotification:(NSString *)key{
    return _dicTypeAndLocalNotification[key];
}

@end
