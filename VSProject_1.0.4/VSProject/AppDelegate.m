//
//  AppDelegate.m
//  VSProject
//
//  Created by user on 15/1/10.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "AppDelegate.h"
#import "VSRootTabBarViewController.h"
#import "VSNavigationViewController.h"
#import "VSFindTableViewController.h"
#import "VSZixunSquareViewController.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "VSLocationManager.h"
#import "NSObject+VSSwizzle.h"
#import "VSMessageHeader.h"
#import <JSONModel.h>
#import <OpenUDID.h>
#import "VSVersionCheckManager.h"
#import "VSWebViewController.h"
#import "VSShareManager.h"
#import "DBHelpQueueManager.h"
#import "VSMsgChatManager.h"
#import "VSIAPManager.h"
#import "VSTestListViewController.h"
#import "VSFileHelper.h"
#import "VSUserLoginViewController.h"
#import "LDResisterManger.h"
#import "JPUSHService.h"
#import "HomeCNewViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlixPayResult.h"
#import "GuideViewController.h"
#import "MobClick.h"
#import "MessageContentViewController.h"
#import "DiscoveryViewController.h"
#import "HomeBTabbarViewController.h"
#import "CenterViewController.h"
#import "BHomeViewController.h"
#import "NewNearViewController.h"
#import "NewCenterViewController.h"
#import "GreatActivityListViewController.h"
#import "BidListViewController.h"
#import "BidderManager.h"
#import "ServerViewController.h"
#import "MeCenterViewController.h"
#import "DiscoverViewController.h"
#import "NewShareWebViewController.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define WeiXinAppId @"wx67dc6cf99d12873a"
#define UmengAppKey @"56821e1067e58edc53002526"


@interface AppDelegate ()<UITabBarControllerDelegate,JPUSHRegisterDelegate> {
    
    VSNavigationViewController *guideNavigation;
    CGRect rect;
    BOOL checkPass;
    BOOL launchAnimationFireout;
    UIImageView *launchImage;
    UIWebView *launchGif;
}

_PROPERTY_NONATOMIC_STRONG(NSArray, tabbarDataSource);

_PROPERTY_NONATOMIC_STRONG(VSRootTabBarViewController, rootVC);


@end

@implementation AppDelegate
@synthesize tb;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotification_name_loginSuccess object:nil];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //启动设置
    [self vs_startManager];
    
    //登录成功获取bid数据
    [BidderManager  shareInstance];
    
    
    [self setRootNav];
    
    
    [self.window setBackgroundColor:kColor_cccccc];
    
    [VSUserLogicManager shareInstance].userDataInfo = [VSUserDataInfo vp_loadLocal];
    
    checkPass = NO;
    launchAnimationFireout = NO;
    [self checkInterfaceVersion];
    
    //开启极光推送
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions
                           appKey:@"cedf79f550682349b8ea15ab"
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
//    [Notification startJPushWithOptions:launchOptions];
    
    application.applicationIconBadgeNumber = 0;
    
    [WXApi registerApp:WeiXinAppId];
    
    //友盟
    [MobClick startWithAppkey:UmengAppKey reportPolicy:BATCH channelId:nil];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    //开始定位
    [[VSLocationManager shareInstance] location];
    [VSLocationManager shareInstance].delegate = self;
    
    
    return YES;
}

#pragma mark - 启动后操作

//开机启动页动画
- (void)launchImageAnimation {
//    if (!launchImage) {
//        launchImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
//        launchImage.image = [UIImage imageNamed:@"launch1.jpg"];
//    }
//    [self.window.rootViewController.view addSubview:launchImage];
//    
//    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake((MainWidth-160)/2, 0.8*MainHeight-80, 160, 80)];
//    iconImage.image = [UIImage imageNamed:@"loading"];
//    [launchImage addSubview:iconImage];
//    
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:launchImage,@"launchImage", nil];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(launchImageAddmoveImage:) userInfo:dic repeats:YES];
//    rect = CGRectMake((MainWidth-24*7)/2, 0.8*MainHeight+10, 18, 24);
//    [timer fire];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        launchAnimationFireout = YES;
//        if (checkPass) {
//            [self hideLaunchImage];;
//        }
//        if (timer) {
//            [timer invalidate];
//        }
//    });
    
    if (!launchImage) {
        launchImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
        launchImage.image = [UIImage imageNamed:@"launch1.jpg"];
    }
    
    [self.window.rootViewController.view addSubview:launchImage];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.03f target:self selector:@selector(launchImageMove:) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)hideLaunchImage {
    [UIView animateWithDuration:0.0f animations:^{
        launchImage.alpha = 0.0f;
    }completion:^(BOOL finished) {
        [launchImage removeFromSuperview];
    }];
}

- (void)launchImageMove:(NSTimer *)timer {
    static NSInteger i = 0;
    i++;
    NSLog(@"launch%ld",(long)i);
    launchImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"launch%ld.jpg",(long)i]];
    if (i == 10) {
        launchAnimationFireout = YES;
        [self hideLaunchImage];
        if (timer) {
            [timer invalidate];
        }
    }
}

- (void)launchImageAddmoveImage:(NSTimer *)Timer {
    UIImageView *moveImage = [[UIImageView alloc]init];
    rect.origin.x += rect.size.width;
    moveImage.frame = rect;
    moveImage.image = [UIImage imageNamed:@"加载条"];
    [UIView animateWithDuration:0.3f animations:^{
        [launchImage addSubview:moveImage];
    }];
    
}


//自动登录

#pragma  mark - request

- (void)autoLogin {
    
    LDResisterManger *manger = [[LDResisterManger alloc]init];
    NSString *userRegiesterPath = [LocalStorage userRegiesterPath];
    NSDictionary *userRegiesterDic = [NSDictionary dictionaryWithContentsOfFile:userRegiesterPath];
    if (!userRegiesterDic) {
        userRegiesterDic = [[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo toDictionary];
    }
    
    if (userRegiesterDic) {
        [manger requestLogin:userRegiesterDic success:^(NSDictionary *responseObj) {
            
        } failure:^(NSError *error) {
            
        }];
    }
}
- (void)checkInterfaceVersion {
    
    LDResisterManger *manger = [[LDResisterManger alloc]init];
    [manger checkInterfaceVersion:nil success:^(NSDictionary *responseObj) {
        
        NSString *resultCode = [responseObj objectForKey:@"resultCode"];
        
        if (resultCode && [resultCode isEqualToString:@"SYSERM-10000"]) {
            //            checkPass = NO;
            //            RIButtonItem *item = [RIButtonItem itemWithLabel:@"确定" action:^{
            //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/gb/app/yi-dong-cai-bian/id1059638116?mt=8"]];
            //            }];
            //            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的版本过旧，请升级至最新版本！" cancelButtonItem:item otherButtonItems:nil, nil];
            //            [alert show];
            //ios不允许有版本更新的东西
            checkPass = YES;
            //自动登录
            [self autoLogin];
            if (launchAnimationFireout) {
                [self hideLaunchImage];
            }
            //end
        }else {
            checkPass = YES;
            //自动登录
            [self autoLogin];
            if (launchAnimationFireout) {
                [self hideLaunchImage];
            }
        }
    } failure:^(NSError *error) {
        checkPass = YES;
        //自动登录
        [self autoLogin];
        if (launchAnimationFireout) {
            [self hideLaunchImage];
        }
    }];
}

//程序进入
- (void)setRootNav {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    tb = [[UITabBarController alloc]init];
    tb.tabBar.backgroundColor = _COLOR_HEX(0x98ffffff);
    tb.delegate = (id<UITabBarControllerDelegate>)self;
    tb.tabBar.tintColor = _COLOR_HEX(0x898989);
    
    NSMutableArray *tabVcArray = [NSMutableArray array];
    for (VSTabBarItemData *tbData in self.tabbarDataSource) {
        VSBaseViewController *vc = tbData.tabItemViewController;
        VSNavigationViewController *vcNav = [[VSNavigationViewController alloc]initWithRootViewController:vc];
        vc.tabBarItem.title = tbData.tabItemTitle;
        vc.tabBarItem.image = [UIImage imageNamed:tbData.tabItemNormalImageName];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:tbData.tabItemSelectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSDictionary * attributes = @{NSForegroundColorAttributeName:_COLOR_HEX(0x00c78c)};
        [vc.tabBarItem setTitleTextAttributes:attributes forState:UIControlStateHighlighted];
        [tabVcArray addObject:vcNav];
    }
    tb.viewControllers = [NSArray arrayWithArray:tabVcArray];
    
    NSString *firstLoad = [[VSUserDefaultManager shareInstance]vs_objectForKey:@"firstLoad"];
    if ([firstLoad isEqual:[NSNull null]] || firstLoad.intValue == 0) {
        //首次安装 删除之前的Jpush别名
        [Notification removeJPushAlias];
        
        GuideViewController *firstView=[[GuideViewController alloc]init];
        guideNavigation=[[VSNavigationViewController alloc] initWithRootViewController:firstView];
        firstView.nextRoot = (UINavigationController *)tb;
        firstView.needDisapperButton = YES;
        [self.window addSubview:guideNavigation.view];
        self.window.rootViewController = guideNavigation;
    }else {
        self.window.rootViewController = tb;
    }
    [[VSUserDefaultManager shareInstance] vs_setObject:@"1" forKey:@"firstLoad"];
    [self launchImageAnimation];
    
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    VSNavigationViewController *vcNav = (VSNavigationViewController *)viewController;
    UIViewController *vc = [vcNav.viewControllers firstObject];
    
    //    if ([vc isKindOfClass:[HomeCNewViewController class]]) {
    //        
    //    }else if ([vc isKindOfClass:[HomeBTabbarViewController class]]) {
    //        
    //    }else if ([vc isKindOfClass:[DiscoveryViewController class]]) {
    //        
    //    }else if ([vc isKindOfClass:[CenterViewController class]]) {
    //        
    //    }
    
    return YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    VSNavigationViewController *vcNav = (VSNavigationViewController *)viewController;
    
    if (tabBarController.selectedIndex == 0) {
        
    }else if (tabBarController.selectedIndex == 1) {
        
        //        HomeBTabbarViewController *vc = [vcNav.viewControllers firstObject];
        //        if ([vc isKindOfClass:[HomeBTabbarViewController class]]) {
        //            [vc pushToB];
        //            
        //        }
    }else if (tabBarController.selectedIndex == 2) {
        
    }else if (tabBarController.selectedIndex == 3) {
        MeCenterViewController *vc = [vcNav.viewControllers firstObject];
        if ([vc isKindOfClass:[MeCenterViewController class]]) {
            [vc userlogin:LOGIN_BACK_HOME popVc:vc animated:YES LoginSucceed:^{
                
            } cancel:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [tabBarController setSelectedIndex:0];
                });
            }];
            
//            if ([self isUserlogin:LOGIN_BACK_HOME popVc:vc animated:NO]) {
//                if (vc.navigationController.viewControllers.count > 1) {
//                    [vc.navigationController popToRootViewControllerAnimated:NO];
//                }
//            }
        }
    }
}

- (BOOL)isUserlogin:(LOGIN_BACK)backwhere popVc:(UIViewController *)vc animated:(BOOL)animated{
    //判断是否登录
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    if (!partyId) {
        VSUserLoginViewController *controller = [[VSUserLoginViewController alloc]init];
        controller.backWhere = backwhere;
        [vc.navigationController pushViewController:controller animated:animated];
        return NO;
    }else {
        return YES;
    }
}

- (void)vs_startManager
{
#ifndef DEBUG
    //采用防崩溃处理
    //    [[NSObject class] swizzleAll];
#endif
    //
    //初始化数据库
    [DBHelpQueueManager shareInstance];
    
    //初始化IAP
    [VSIAPManager shareInstance];
    
    //初始化定位
    [VSLocationManager shareInstance];
    
    //初始化userlogic
    [VSUserLogicManager shareInstance];
    
    //初始化motionlogic
    [RTXMotionLogicManager shareInstance];
    
}


#pragma mark -- application
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSNotification * yzmnotice = [NSNotification notificationWithName:@"YZMTIMER" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:yzmnotice];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler: (void (^)(UIBackgroundFetchResult))completionHandler {
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    [self pushAlertInApp:application userInfo:userInfo];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self pushAlertInApp:application userInfo:userInfo];
    
    
}

- (void)pushAlertInApp:(UIApplication *)application userInfo:(NSDictionary *)userInfo {
    
    DBLog(@"userInfo--%@",userInfo);
    
    if (application.applicationState == UIApplicationStateActive) {
        [JPUSHService handleRemoteNotification:userInfo];
        application.applicationIconBadgeNumber = 1;
        application.applicationIconBadgeNumber = 0;
        
        NSString *url = [userInfo objectForKey:@"url"];
        NSString *MESSAGE_ID = [userInfo objectForKey:@"MESSAGE_ID"];
        if (![url isEqualToString:@""]) {
            if ([url hasPrefix:@"http"]) {
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:url]];
                    [[VSPageRoute currentNav] pushViewController:vc animated:YES];
                });
            } else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:url delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else {
            if (![MESSAGE_ID isEqualToString:@""]) {
                MessageModel *model = [MessageModel new];
                model.id = [[userInfo objectForKey:@"extras"] objectForKey:@"MESSAGE_ID"];
                MessageContentViewController *vc = [[MessageContentViewController alloc]init];
                vc.m_model = model;
                [self.window.rootViewController presentViewController:vc animated:NO completion:^{
                    //
                }];
            }
        }
    }else {
        NSString *url = [userInfo objectForKey:@"url"];
        NSString *MESSAGE_ID = [userInfo objectForKey:@"MESSAGE_ID"];
        if (![url isEqualToString:@""]) {
            if ([url hasPrefix:@"http"]) {
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:url]];
                    [[VSPageRoute currentNav] pushViewController:vc animated:YES];
                });
            } else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:url delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else {
            if (![MESSAGE_ID isEqualToString:@""]) {
                MessageModel *model = [MessageModel new];
                model.id = [[userInfo objectForKey:@"extras"] objectForKey:@"MESSAGE_ID"];
                MessageContentViewController *vc = [[MessageContentViewController alloc]init];
                vc.m_model = model;
                [self.window.rootViewController presentViewController:vc animated:NO completion:^{
                    //
                }];
            }
        }
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken=%@",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
        [self pushAlertInApp:[UIApplication sharedApplication] userInfo:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        [self pushAlertInApp:[UIApplication sharedApplication] userInfo:userInfo];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    if ([url.scheme isEqualToString:WeiXinAppId]) {
        return [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    }
    
    return [[VSShareManager shareInstance] vs_handleOpenURL:url];
    //    return  [[ShareManager sharedManager] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //如果涉及其他应用交互,请做如下判断,例如:还可能和新浪微博进行交互
    if ([url.scheme isEqualToString:WeiXinAppId])
    {
        return [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    }
    
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            
            //            resultDic = resultDic[@"reslut"];
            
            
            //结果处理
            AlixPayResult* result = [[AlixPayResult alloc] initWithDict:resultDic];
            
            if (result)
            {
                
                if (result.statusCode == 9000)
                {
                    /*
                     *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
                     */
                    
                    //交易成功
                    
                    [self.window showTipsView:@"支付成功"];
                    //验证签名成功，交易结果无篡改
                    NSNotification *notification = [NSNotification notificationWithName:kALPaySucNotification object:@"success"];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                    
                    
                }else if(result.statusCode == 6001)
                {
                    
                    
                    
                    [self.window showTipsView:@"您已取消支付"];
                    
                    NSNotification *notification = [NSNotification notificationWithName:kALPayFailNotification object:@"fail"];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }
                else
                {
                    [self.window showTipsView:@"支付失败"];
                    //交易失败
                    NSNotification *notification = [NSNotification notificationWithName:kALPayFailNotification object:@"fail"];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }
            }
            else
            {
                //失败
                NSNotification *notification = [NSNotification notificationWithName:kALPayFailNotification object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
            
            
            
        }];
        
        return YES;
    }
    
    
    return [[VSShareManager shareInstance] vs_handleOpenURL:url];
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        NSLog(@"发送返回结果：%@",strMsg);
    }
    
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        
        switch (response.errCode)
        {
            case WXSuccess:
            {
                [self.window showTipsView:@"支付成功"];
                NSNotification *notification = [NSNotification notificationWithName:kWXPaySucNotification object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            case WXErrCodeUserCancel:
            {
                [self.window showTipsView:@"您已取消支付"];
                NSNotification *notification = [NSNotification notificationWithName:kWXPayFailNotification object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
                
            default:
            {
                [self.window showTipsView:@"支付失败"];
                NSNotification *notification = [NSNotification notificationWithName:kWXPayFailNotification object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
        }
    }
}

#pragma mark -- getter
_GETTER_BEGIN(NSArray, tabbarDataSource)
{
    //    HomeCNewViewController *homeC = [[HomeCNewViewController alloc] init];
    
    BHomeViewController  *bhome = [[BHomeViewController alloc] init];
    
    
    //    HomeBTabbarViewController *homeB = [HomeBTabbarViewController shareInstance];
    
//    NewNearViewController *nearVC = [[NewNearViewController alloc] init];
    
    ServerViewController *serverVC = [[ServerViewController alloc] init];
    
    //    DiscoveryViewController *discovery = [[DiscoveryViewController alloc] init];
    
//    GreatActivityListViewController *discovery = [GreatActivityListViewController new];
    DiscoverViewController *discovery = [[DiscoverViewController alloc] init];
    
    //    CenterViewController *center= [[CenterViewController alloc] init];
    
//    NewCenterViewController *center = [[NewCenterViewController alloc] init];
    MeCenterViewController *center = [[MeCenterViewController alloc] init];
    
    NSArray *vcs = @[bhome,serverVC,discovery,center];
    NSArray *titles = @[@"首页",@"服务",@"发现",@"我的"];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[titles count]];
    for(NSInteger i = 0; i<[titles count]; ++i)
    {
        [items addObject:[[VSTabBarItemData alloc]initWithTitle:titles[i]
                                                    normalImage:[self vs_tabNormalImageNameForIndex:i]
                                                  selectedImage:[self vs_tabSelectedImageNameForIndex:i]
                                                 viewController:vcs[i]]];
    }
    
    _tabbarDataSource = [NSArray arrayWithArray:items];
}
_GETTER_END(tabbarDataSource)

- (NSString*)vs_tabNormalImageNameForIndex:(NSInteger)index
{
    NSArray *names = @[@"ic_home_n",@"ic_service_n",@"ic_find_n",@"ic_me_n"];
    
    return names[index];
}

- (NSString*)vs_tabSelectedImageNameForIndex:(NSInteger)index
{
    //    return [NSString stringWithFormat:@"home_tab%ld_selected", (long)index];
    
    NSArray *names = @[@"ic_home_p",@"ic_service_p",@"ic_find_p",@"ic_me_p"];
    
    return names[index];
}

_GETTER_ALLOC_BEGIN(VSRootTabBarViewController, rootVC)
{
    _rootVC.delegate = self;
}
_GETTER_END(rootVC)


@end
