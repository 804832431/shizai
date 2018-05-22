//
//  HomeViewController.m
//  VSProject
//
//  Created by 姚君 on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "HomeViewController.h"
#import "PersonalHomeView.h"
#import "EnterpriseHomeView.h"
#import "VSNavigationViewController.h"
#import "VSUserLoginViewController.h"
#import "CenterViewController.h"
#import "VSJsWebViewController.h"
#import "ChangeLocatiionViewController.h"
#import "RTXShakeViewController.h"
#import "RTXOrganizationParm.h"
#import "O2OOrderDetailViewController.h"
#import "OrderDetailViewController.h"
#import "MyOrdersViewController.h"

@interface HomeViewController () {
    
    NSString *userType;
    BOOL      isBHomeShow;//当前Home显示的页面是否为B端
}

_PROPERTY_NONATOMIC_STRONG(PersonalHomeView, personalHome)
_PROPERTY_NONATOMIC_STRONG(EnterpriseHomeView, enterpriseHome)
_PROPERTY_NONATOMIC_STRONG(VSNavigationViewController, navHome)

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    //    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 1, MainWidth, 64)];
    //    bg.backgroundColor = [UIColor blackColor];
    //    [self.view addSubview:bg];
    
    _personalHome  = [[PersonalHomeView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    _enterpriseHome  = [[EnterpriseHomeView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    _personalHome.selfController = self;
    _enterpriseHome.selfController = self;
    userType = [[VSUserDefaultManager shareInstance]vs_objectForKey:@"userType"];
    //默认是C端
    [self setHomeViewWithState:[VSUserLogicManager shareInstance].userDataInfo.state];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//C端
- (void)cHomeShow{
    [self.view insertSubview:_personalHome atIndex:1];
    [self.view insertSubview:_enterpriseHome atIndex:0];
}

//B端
- (void)bHomeShow{
    [self.view insertSubview:_personalHome atIndex:0];
    [self.view insertSubview:_enterpriseHome atIndex:1];
}

- (void)setHomeViewWithState:(HOMEVIEW_STATE)tag{
    switch (tag) {
        case NOTLOGIN_STATE:
        {
            [self cHomeShow];
            isBHomeShow = NO;
        }
            break;
        case LIMITCHOME_STATE:
        {
            [self cHomeShow];
            isBHomeShow = NO;
        }
            break;
        case ACCESSBHOME_STATE:
        {
            [self bHomeShow];
            isBHomeShow = YES;
        }
            break;
        default:
        {
            [self.view showTipsView:@"系统异常!" afterDelay:3.0];
        }
            break;
    }
}
#pragma mark -- private

- (BOOL)isUserlogin {
    //判断是否登录
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    if (!partyId) {
        VSUserLoginViewController *controller = [[VSUserLoginViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        return YES;
    }else {
        return NO;
    }
}
#pragma mark -- public

- (void)changeLocation {
    
    ChangeLocatiionViewController *controller = [[ChangeLocatiionViewController alloc]init];
    __weak typeof(_personalHome)_weakpersonalHome = _personalHome;
    controller.resetLayout = ^{
        [_weakpersonalHome requestLayout];
    };
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)changeHome {
    //切换首页模式
    
    userType = [[VSUserDefaultManager shareInstance]vs_objectForKey:@"userType"];
    if ([userType isEqual:[NSNull null]] || !userType) {
        [VSUserLogicManager shareInstance].userDataInfo.state = NOTLOGIN_STATE;
    }else if ([userType isEqualToString:@"0"]){
        [VSUserLogicManager shareInstance].userDataInfo.state = LIMITCHOME_STATE;
    }else{
        [VSUserLogicManager shareInstance].userDataInfo.state = ACCESSBHOME_STATE;
    }
    //切换Home,如果在C端切换则需验证权限
    if (!isBHomeShow) {
        if ([VSUserLogicManager shareInstance].userDataInfo.state != ACCESSBHOME_STATE) {
            NSString *tip = ([VSUserLogicManager shareInstance].userDataInfo.state == NOTLOGIN_STATE)?@"您是游客身份，请先登录！":@"您未取得企业用户权限！";
            [self.view showTipsView:tip afterDelay:1.5];
            return;
        }else{
            //发送请求，创建B端View
            [self vs_showLoading];
            RTXOrganizationParm *parm = _ALLOC_OBJ_(RTXOrganizationParm);
            parm.organization_id = [[VSUserLogicManager shareInstance]userDataInfo].vm_projectInfo.organizationId;
            parm.page = @"-1";
            parm.row = @"-1";
            [[VSUserLogicManager shareInstance] vs_getApplicationsForB:parm success:^(id result, id data) {
                NSDictionary *dataDic = (NSDictionary *)data;
                //字典转化成Model
                RTXBapplicationsModel *dataModel = [[RTXBapplicationsModel alloc]initwithDic:dataDic];
                [self vs_hideLoadingWithCompleteBlock:^{
                    [_enterpriseHome vp_updateUIWithModel:dataModel];
                    [self.view showTipsView:@"应用获取成功！" afterDelay:0.5];
                }];
            } failed:^(id result, id data) {
                [self vs_hideLoadingWithCompleteBlock:^{
                    [self.view showTipsView:@"B端列表获取失败！" afterDelay:0.5];
                }];
            }];
            //
        }
    }
    
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    //切换页面
    isBHomeShow = !isBHomeShow;
    [UIView commitAnimations];
}


- (void)userCenter {
    
    UIViewController *controller;

    //判断是否登录
    if (![self isUserlogin]) {
        CenterViewController *controller = [[CenterViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    /*
     _navHome = [[VSNavigationViewController alloc]initWithRootViewController:controller];
     _navHome.view.frame = CGRectMake(GetWidth(self.view), 0, GetWidth(self.view), GetHeight(self.view));
     [self.view addSubview:_navHome.view];
     
     [UIView animateWithDuration:.4f animations:^{
     _navHome.view.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view));
     }completion:^(BOOL finished) {
     }];
     */
}

- (void)customizeHome {
    
}



- (void)tojswebview{
    //    VSJsWebViewController *jswebvc = [[VSJsWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://172.16.31.144/rui/control/getHomePageProducts?id=Gshop"]];
    VSJsWebViewController *jswebvc = [[VSJsWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://172.16.16.144:8080/rui/control/getHomePageProducts?id=Gshop"]];
    //    VSJsWebViewController *jswebvc = [[VSJsWebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:jswebvc animated:YES];
    
}

- (void)toShakeview{
    RTXShakeViewController *shakevc = [[RTXShakeViewController alloc] init];
    [self.navigationController pushViewController:shakevc animated:YES];
}

@end
