//
//  HomeBTabbarViewController.m
//  VSProject
//
//  Created by certus on 16/3/8.
//  Copyright © 2016年 user. All rights reserved.
//

#import "HomeBTabbarViewController.h"
#import "VSRootTabBarViewController.h"
#import "HomeBNewViewController.h"
#import "ManagementViewController.h"
#import "VSNavigationViewController.h"
#import "GreatActivityListViewController.h"
#import "EnterpriseInfoViewController.h"
#import "NotificationAgentViewController.h"
#import "LDResisterManger.h"
#import "VSUserLoginViewController.h"

@interface HomeBTabbarViewController ()

_PROPERTY_NONATOMIC_STRONG(NSArray, tabbarDataSource);



@end


@implementation HomeBTabbarViewController

DECLARE_SINGLETON(HomeBTabbarViewController)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self vs_setTitleText:@"企业"];
    [KNotificationCenter addObserver:self selector:@selector(tabHomeC:) name:kHome_BackHomeC object:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabHomeC:(NSNotification *)notification {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.tb.selectedIndex = 0;

}

- (void)judgeRole {
    [self presentViewController:self.tb animated:NO completion:nil];
    NSString *roleInCompany =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.roleInCompany;
    if (roleInCompany && [roleInCompany isEqualToString:@"admin"]) {
        self.tb.selectedIndex = 3;
    }else {
        self.tb.selectedIndex = 0;
    }
    
}

- (void)pushToB {

    NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    
    if (partyId && ![partyId isEmptyString]) {
        NSDictionary *dic = @{@"partyId":partyId};
        LDResisterManger *manger = [[LDResisterManger alloc]init];
        [self vs_showLoading];
        [manger requestInviaterRole:dic success:^(NSDictionary *responseObj) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self judgeRole];
        } failure:^(NSError *error) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self judgeRole];
        }];
    }else {
        [self judgeRole];
    }
}


#pragma mark - UITabBarControllerDelegate

- (void)judgeRole:(UITabBarController *)tabBarController {
    NSString *roleInCompany =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.roleInCompany;
    if (roleInCompany && [roleInCompany isEqualToString:@"admin"]) {
        tabBarController.selectedIndex = 3;
    }else {
        [tabBarController.selectedViewController.view showTipsView:@"对不起，您没有管理员权限！" afterDelay:0.4f completeBlock:^{
            if (tabBarController.selectedIndex ==3) {
                tabBarController.selectedIndex = 0;
            }
        }];
    }

}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    VSNavigationViewController *vcNav = (VSNavigationViewController *)viewController;
    UIViewController *vc = [vcNav.viewControllers firstObject];
    
    if ([vc isKindOfClass:[HomeBNewViewController class]]) {

    }else if ([vc isKindOfClass:[NotificationAgentViewController class]]) {
        
    }else if ([vc isKindOfClass:[GreatActivityListViewController class]]) {

    }else if ([vc isKindOfClass:[ManagementViewController class]]) {

        [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
            NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
            
            if (partyId && ![partyId isEmptyString]) {
                NSDictionary *dic = @{@"partyId":partyId};
                LDResisterManger *manger = [[LDResisterManger alloc]init];
                [manger requestInviaterRole:dic success:^(NSDictionary *responseObj) {
                    
                    [self judgeRole:tabBarController];
                } failure:^(NSError *error) {
                    
                    [self judgeRole:tabBarController];
                }];

            }
        } cancel:^{
            
        }];
    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

    VSNavigationViewController *vcNav = (VSNavigationViewController *)viewController;
    UIViewController *vc = [vcNav.viewControllers firstObject];
    
    if ([vc isKindOfClass:[HomeBNewViewController class]]) {
        
    }else if ([vc isKindOfClass:[NotificationAgentViewController class]]) {
        [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
            NotificationAgentViewController *nvc = (NotificationAgentViewController *)vc;
            [nvc refresh];
        } cancel:^{
            
        }];
        
    }else if ([vc isKindOfClass:[GreatActivityListViewController class]]) {
        GreatActivityListViewController *gvc = (GreatActivityListViewController *)vc;
        [gvc refresh];
        
    }else if ([vc isKindOfClass:[ManagementViewController class]]) {
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- getter
_GETTER_BEGIN(NSArray, tabbarDataSource)
{
    HomeBNewViewController *homeB = [[HomeBNewViewController alloc] init];
    NotificationAgentViewController *notificationAgent = [[NotificationAgentViewController alloc]init];
    GreatActivityListViewController *activity = [[GreatActivityListViewController alloc] init];
    ManagementViewController *manage = [[ManagementViewController alloc] init];

    NSArray *vcs = [NSArray arrayWithObjects:homeB,notificationAgent,activity,manage, nil];
    NSArray *titles = @[@"应用",@"通知待办",@"发现",@"企业管理"];

    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[titles count]];
    for(NSInteger i = 0; i<[titles count]; ++i)
    {
        [items addObject:[[VSTabBarItemData alloc]initWithTitle:titles[i]
                                                    normalImage:[self vs_tabNormalImageNameForIndex:i]
                                                  selectedImage:[self vs_tabSelectedImageNameForIndex:i]
                                                 viewController:vcs[i]]];
    }
    
    return [NSArray arrayWithArray:items];
}
_GETTER_END(tabbarDataSource)

- (NSString*)vs_tabNormalImageNameForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"business_tab%ld_normal", (long)index];
}

- (NSString*)vs_tabSelectedImageNameForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"business_tab%ld_selected", (long)index];
}

_GETTER_ALLOC_BEGIN(UITabBarController, tb)
{
    _tb = [[UITabBarController alloc]init];
    _tb.tabBar.backgroundColor = _COLOR_HEX(0x99f4f4f4);
    _tb.delegate = (id<UITabBarControllerDelegate>)self;
    _tb.tabBar.tintColor = _COLOR_HEX(0x35b38d);
    
    NSMutableArray *tabVcArray = [NSMutableArray array];
    for (VSTabBarItemData *tbData in self.tabbarDataSource) {
        VSBaseViewController *vc = tbData.tabItemViewController;
        VSNavigationViewController *vcNav = [[VSNavigationViewController alloc]initWithRootViewController:vc];
        vc.tabBarItem.title = tbData.tabItemTitle;
        vc.tabBarItem.image = [UIImage imageNamed:tbData.tabItemNormalImageName];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:tbData.tabItemSelectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [tabVcArray addObject:vcNav];
    }
    _tb.viewControllers = [NSArray arrayWithArray:tabVcArray];
    
    return _tb;
}
_GETTER_END(tb)


@end
