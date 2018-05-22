//
//  VSPageRoute.m
//  VSProject
//
//  Created by apple on 1/4/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "VSPageRoute.h"
#import "NewShareWebViewController.h"
#import "RTXCAppModel.h"
#import "BidListViewController.h"
#import "DiscoverViewController.h"
#import "NewPolicyListViewController.h"
#import "GreatActivityListViewController.h"
#import "SpaceModel.h"
#import "SpacePageViewController.h"
#import "RTXBapplicationInfoModel.h"
#import "FinanceViewController.h"
#import "ServiceModel.h"
#import "VSUserLoginViewController.h"
#import "EnterpriceInfoViewController.h"
#import "NewActivityDetailViewController.h"
#import "NewPolicyDetaileViewController.h"
#import "BidWebViewController.h"
#import "SpaceLeaseListViewController.h"

@implementation VSPageRoute

+(void)routeToTarget:(id)object {
    if ([object isKindOfClass:[RTXCAppModel class]]) {
        RTXCAppModel *appModel = (RTXCAppModel *)object;
        
        if ([appModel.visitkeyword isEqualToString:@"ztb"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToZTB];
            
        } else if ([appModel.visitkeyword isEqualToString:@"enterprise"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToQYPD];
            
        } else if ([appModel.visitkeyword isEqualToString:@"enterpriseClub"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToQYJJLB];
            
        } else if ([appModel.visitkeyword isEqualToString:@"policy"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToZC];
            
        } else if ([appModel.visitkeyword isEqualToString:@"enterpriseFinance"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToQYJR];
            
        } else if ([appModel.visitkeyword isEqualToString:@"activity"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToHD];
        } else if ([appModel.visitkeyword isEqualToString:@"space"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToSpace:SPACE_LEASE_TYPE_OLD];
        } else if ([appModel.visitkeyword isEqualToString:@"spaceLeaseNew"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToSpace:SPACE_LEASE_TYPE];
        } else {
//            NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:appModel.productDetail]];
//            [[self currentNav] pushViewController:vc animated:YES];
            if ([appModel.visitType isEqualToString:@"NATIVE"]) {
            } else {
                NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"]?:@"0";
                NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]?:@"0";
                NSString *visitKeyword = [NSString stringWithFormat:@"%@&longitude=%@&latitude=%@", appModel.visitkeyword, longitude, latitude];
                appModel.visitkeyword = visitKeyword;
                [VSPageRoute toApplication:appModel fromController:[VSPageRoute currentNav]];
            }
        }
        
    } else if ([object isKindOfClass:[SpaceModel class]]) {
        SpaceModel *spaceModel = (SpaceModel *)object;
        if ([spaceModel.classId isEqualToString:@"spaceAcquisition"]) {
            //空间购置
            [self routeToSpace:SPACE_ACQUISITION];
        } else if ([spaceModel.classId isEqualToString:@"mobileStation"]) {
            //移动工位
            [self routeToSpace:MOBILE_STATION_TYPE];
        } else if ([spaceModel.classId isEqualToString:@"conferenceRoom"]) {
            //会议室
            [self routeToSpace:CONFERENCE_ROOM_TYPE];
        } else if ([spaceModel.classId isEqualToString:@"spaceLeaseNew"] || [spaceModel.classId isEqualToString:@"spaceLease"]) {
            //空间租赁
            [self routeToSpace:SPACE_LEASE_TYPE];
        }
        
    } else if ([object isKindOfClass:[RTXBapplicationInfoModel class]]) {
        RTXBapplicationInfoModel *appModel = (RTXBapplicationInfoModel *)object;
        if ([appModel.visitkeyword isEqualToString:@"ztb"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToZTB];
            
        } else if ([appModel.visitkeyword isEqualToString:@"enterprise"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToQYPD];
            
        } else if ([appModel.visitkeyword isEqualToString:@"enterpriseClub"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToQYJJLB];
            
        } else if ([appModel.visitkeyword isEqualToString:@"policy"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToZC];
            
        } else if ([appModel.visitkeyword isEqualToString:@"enterpriseFinance"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToQYJR];
            
        } else if ([appModel.visitkeyword isEqualToString:@"activity"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToHD];
        } else if ([appModel.visitkeyword isEqualToString:@"space"] && [appModel.visitType isEqualToString:@"NATIVE"]) {
            [self routeToSpace:SPACE_LEASE_TYPE];
        }
    } else if ([object isKindOfClass:[ServiceModel class]]) {
        ServiceModel *model = (ServiceModel *)object;
        if ([model.type isEqualToString:@"enterprise"]) {
            //企业web页
            EnterpriceInfoViewController *vc = [[EnterpriceInfoViewController alloc] initWithUrl:[NSURL URLWithString:model.enterprise.enterpriseDetail]];
            vc.barColorStr = model.enterprise.themeColor;
            [vc hideFlow];
            [[self currentNav] pushViewController:vc animated:YES];
        } else if ([model.type isEqualToString:@"activity"]) {
            //活动web页
            NewActivityDetailViewController *vc = [[NewActivityDetailViewController alloc] init];
            vc.a_model = model.activity;
            vc.webUrl = [NSURL URLWithString:vc.a_model.activityDetail];
            [[self currentNav] pushViewController:vc animated:YES];
        } else if ([model.type isEqualToString:@"policy"]) {
            //政策web页
            NewPolicyDetaileViewController *vc = [[NewPolicyDetaileViewController alloc] init];
            vc.webUrl = [NSURL URLWithString:model.policy.policyDetail];
            vc.p_model = model.policy;
            [[self currentNav] pushViewController:vc animated:YES];
        } else if ([model.type isEqualToString:@"space"]) {
            //空间web页
            NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:model.space.spaceDetail]];
            [[self currentNav] pushViewController:vc animated:YES];
        } else if ([model.type isEqualToString:@"bid"]) {
            //政策web页
            BidWebViewController *vc = [[BidWebViewController alloc] initWithUrl:[NSURL URLWithString:model.bidProject.projectUrl]];
            vc.isHomeList = YES;
            vc.dto = model.bidProject;
            [[self currentNav] pushViewController:vc animated:YES];
        } else if ([model.type isEqualToString:@"news"]) {
            NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:model.newsDetail]];
            [[self currentNav] pushViewController:vc animated:YES];
        } else {
            NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:model.productDetail]];
            [[self currentNav] pushViewController:vc animated:YES];
        }
    }
}

+ (UITabBarController *)currentTab {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    id controller = appDelegate.window.rootViewController;
    if ([controller isKindOfClass:[UITabBarController class]]) {
        return controller;
    }
    return nil;
}

+ (UINavigationController *)currentNav {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    id controller = appDelegate.window.rootViewController;
    if ([controller isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nav = [((UITabBarController *)controller) selectedViewController];
        return nav;
    }
    return nil;
}

+ (void)routeToZTB {
//    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
//    if (!partyId) {
//        VSUserLoginViewController *controller = [[VSUserLoginViewController alloc]init];
//        [[self currentNav] pushViewController:controller animated:YES];
//    }else {
        BidListViewController *vc = [[BidListViewController alloc] init];
        [[self currentNav] pushViewController:vc animated:YES];
//    }
}

+ (void)routeToQYPD {
    [[self currentTab] setSelectedIndex:2];
    DiscoverViewController *vc = (DiscoverViewController *)[[[self currentTab] selectedViewController] topViewController];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vc selectTabPageeWithIndex:DISCOVER_ENTERPRISE_CHANNEL + 1];
    });
}

+ (void)routeToQYJJLB {
    [[self currentTab] setSelectedIndex:2];
    DiscoverViewController *vc = (DiscoverViewController *)[[[self currentTab] selectedViewController] topViewController];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vc selectTabPageeWithIndex:DISCOVER_ENTERPENEUR_CLUB + 1];
    });
}

+ (void)routeToSZFX {
    [[self currentTab] setSelectedIndex:2];
    DiscoverViewController *vc = (DiscoverViewController *)[[[self currentTab] selectedViewController] topViewController];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vc selectTabPageeWithIndex:DICOVER_SHARE + 1];
    });
}

+ (void)routeToZC {
    NewPolicyListViewController *vc = [[NewPolicyListViewController alloc] init];
    [[self currentNav] pushViewController:vc animated:YES];
}

+ (void)routeToQYJR {
    FinanceViewController *vc = [[FinanceViewController alloc] init];
    [[self currentNav] pushViewController:vc animated:YES];
}

+ (void)routeToHD {
    GreatActivityListViewController *vc = [[GreatActivityListViewController alloc] init];
    [[self currentNav] pushViewController:vc animated:YES];
}

+ (void)routeToSpace:(SPACE_TYPE)classId {
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    if (!partyId) {
        VSUserLoginViewController *controller = [[VSUserLoginViewController alloc]init];
        [[self currentNav] pushViewController:controller animated:YES];
    }else {
        
        if (classId == SPACE_LEASE_TYPE) {
            SpaceLeaseListViewController *vc = [[SpaceLeaseListViewController alloc] init];
            [[self currentNav] pushViewController:vc animated:YES];
        }
        else {
            SpacePageViewController *vc = [[SpacePageViewController alloc] init];
            vc.spaceType = classId;
            [[self currentNav] pushViewController:vc animated:YES];
        }
    }
}

//跳转对应应用
+ (void)toApplication:(id)model fromController:(UINavigationController *)controller {
    
    NSString *visitType = @"";
    NSString *protocol = @"";
    NSString *visitkeyword = @"";
    NSString *appId = @"";
    NSString *catalogId = @"";
    NSString *orderType = @"";
    NSString *appName = @"";
    
    NSString *link = @"";
    if ([model isKindOfClass:[RTXCAppModel class]]) {
        RTXCAppModel *appmodel = (RTXCAppModel *)model;
        visitType = appmodel.visitType;
        protocol = appmodel.protocol;
        visitkeyword = appmodel.visitkeyword;
        appId = appmodel.id;
        catalogId = appmodel.catalogId;
        orderType = appmodel.orderType;
        [[VSUserLogicManager shareInstance] userDataInfo].vm_from = @"C";
        
    }else if ([model isKindOfClass:[RTXBapplicationInfoModel class]]) {
        RTXBapplicationInfoModel *appmodel = (RTXBapplicationInfoModel *)model;
        visitType = appmodel.visitType;
        protocol = appmodel.protocol;
        visitkeyword = appmodel.visitkeyword;
        appId = appmodel.m_id;
        catalogId = appmodel.catalogId;
        orderType = appmodel.orderType;
        [[VSUserLogicManager shareInstance] userDataInfo].vm_from = @"B";
        
        
    }else {
        [controller.view showTipsView:@"跳转错误……" afterDelay:1.5];
        return;
    }
    [[VSUserLogicManager shareInstance] userDataInfo].vm_visitType = visitType;
    [[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId = catalogId;
    [[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId = orderType;
    //modify by Thomas [从O2O应用进B2C应用清空本地购物车，从B2C应用进O2O应用清空本地购物车]－－－end
    NSString *partyId = [[VSUserLogicManager shareInstance] userDataInfo].vm_userInfo.partyId?:@"";
    
    NSString *organizationId = nil;
    if ([model isKindOfClass:[RTXCAppModel class]] && ((RTXCAppModel *)model).organizationId.length > 0) {
        organizationId = ((RTXCAppModel *)model).organizationId;
    }else{
        organizationId = [[VSUserLogicManager shareInstance] userDataInfo].vm_projectInfo.organizationId;
    }
    
    if ([visitType isKindOfClass:[NSNull class]]) {
        visitType = @"H5";
    }
    
    if (visitType && [visitType isEqualToString:@"H5"]) {
        link = [NSString stringWithFormat:@"%@%@&partyId=%@",protocol,visitkeyword,partyId];
        
        NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:link]];
        [controller pushViewController:jswebvc animated:YES];
        
    }else if(visitType && [visitType isEqualToString:@"NATIVE"]){
        if ([visitkeyword isEqualToString:@"wyjkd"])
        {
            NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.sf-express.com/mobile/cn/sc/dynamic_functions/ship/ship.html?isappinstalled=1"]];
            jswebvc.webTitle = @"寄快递";
            [controller pushViewController:jswebvc animated:YES];
        }else if ([visitkeyword isEqualToString:@"kdcx"])
        {
            NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://m.kuaidi100.com/"]];
            jswebvc.webTitle = @"快递查询";
            [controller pushViewController:jswebvc animated:YES];
            
            //            ExpressInquiryViewController *eivc = [[ExpressInquiryViewController alloc]init];
            //            [controller.navigationController pushViewController:eivc animated:YES];
        }else if ([visitkeyword isEqualToString:@"jchd"])//精彩活动
        {
            GreatActivityListViewController *greatController = [[GreatActivityListViewController alloc]init];
            [controller pushViewController:greatController animated:YES];
        }
    }else{
        [controller.view showTipsView:@"请升级至最新版本查看！" afterDelay:1.5];
        return;
    }
}

//dic 转 json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
