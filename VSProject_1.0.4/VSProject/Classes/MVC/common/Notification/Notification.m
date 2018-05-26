//
//  Notification.m
//  EmperorComing
//
//  Created by certus on 15/8/28.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import "Notification.h"
//#import "JPushNotificationExtensionService.h"
#import "JPUSHService.h"

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
        [JPUSHService setupWithOption:launchOptions appKey:@"cedf79f550682349b8ea15ab" channel:@"AppStore" apsForProduction:NO];
    } else {
        //categories 必须为nil
        [JPUSHService setupWithOption:launchOptions appKey:@"cedf79f550682349b8ea15ab" channel:@"AppStore" apsForProduction:NO];
    }
}

//极光打别名
+ (void)setJPushAlias {
    
    //打别名
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;

    if (partyId) {
        NSString *Alia = [NSString stringWithFormat:@"%@%@",partyId,PUSH_SUFFIX];
        [JPUSHService setAlias:Alia completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            if (iResCode != 0) {
                [self setJPushAlias];
            }
        } seq:0];
    }
}

//极光打标签
+ (void)setJPushTag {
    //打标签
    NSSet *tags = [NSSet setWithArray:[NSArray arrayWithObjects:@"customer", nil]];
    [JPUSHService setTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        if (iResCode != 0) {
            [self setJPushTag];
        }
    } seq:0];
}

//极光删别名
+ (void)removeJPushAlias {
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode != 0) {
            [self removeJPushAlias];
        }
    } seq:0];
}

//极光删标签
+ (void)removeJPushTag {
    [JPUSHService deleteTags:[NSSet set] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        if (iResCode != 0) {
            [self removeJPushTag];
        }
    } seq:0];
}

//重打标签对象方法
- (void)resetJPushAlias {
    
    [Notification setJPushAlias];
}


- (void)resetJPushTag {
    
    [Notification setJPushTag];
}


@end
