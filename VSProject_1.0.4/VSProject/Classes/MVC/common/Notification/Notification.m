//
//  Notification.m
//  EmperorComing
//
//  Created by certus on 15/8/28.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import "Notification.h"
#import "APService.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000

@implementation Notification

+ (UILocalNotification *)addLocalNotification:(NSDictionary*)info timeInterval:(NSTimeInterval)interval alertBody:(NSString *)alert{
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:interval];
    notification.fireDate = pushDate;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.alertBody = alert;
    notification.applicationIconBadgeNumber = 0;
    notification.userInfo = info;
    UIApplication *app = [UIApplication sharedApplication];
    [app scheduleLocalNotification:notification];
    
    return notification;
}

+ (void)removeLocalNotification:(NSDictionary*)info {
    
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    //声明本地通知对象
    UILocalNotification *localNotification;
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:[info objectForKey:@"key"]]) {
                    if (localNotification){
                        localNotification = nil;
                    }
                    break;
                }
            }
        }
        
        //判断是否找到已经存在的相同key的推送
        if (!localNotification) {
            //不存在初始化
            localNotification = [[UILocalNotification alloc] init];
        }
        
        if (localNotification) {
            //不推送 取消推送
            [app cancelLocalNotification:localNotification];
            return;
        }
    }  
    
}

//集成极光推送
+ (void)startJPushWithOptions:(NSDictionary *)launchOptions {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
    
    // Required
    [APService setupWithOption:launchOptions];

}

//极光打别名
+ (void)setJPushAlias {
    
    //打别名
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;

    if (partyId) {
        NSString *Alia = [NSString stringWithFormat:@"%@%@",partyId,PUSH_SUFFIX];
        [APService setAlias:Alia callbackSelector:@selector(resetJPushAlias) object:self];
    }
}

//极光打标签
+ (void)setJPushTag {
    //打标签
    NSSet *tags = [NSSet setWithArray:[NSArray arrayWithObjects:@"customer", nil]];
    [APService setTags:tags callbackSelector:@selector(resetJPushTag) object:self];
}

//极光删别名
+ (void)removeJPushAlias {
    
    [APService setAlias:@"" callbackSelector:nil object:self];
}

//极光删标签
+ (void)removeJPushTag {
    
    [APService setTags:[NSSet set] callbackSelector:nil object:self];
}

//重打标签对象方法
- (void)resetJPushAlias {
    
    [Notification setJPushAlias];
}


- (void)resetJPushTag {
    
    [Notification setJPushTag];
}


@end
