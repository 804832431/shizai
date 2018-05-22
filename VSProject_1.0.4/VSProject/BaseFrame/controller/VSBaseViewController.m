//
//  VMBaseViewController.m
//  beautify
//
//  Created by xiangying on 14-11-12.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import "VSBaseViewController.h"
#import "UIViewController+BackBar.h"
#import "VSShareDataSource.h"
#import "RTXShareContextView.h"//#import "VSShareContextView.h"
#import "VSPopView.h"
#import "VSShareManager.h"
#import "VSNetErrorView.h"
#import "RTXCAppModel.h"
#import "VSJsWebViewController.h"
#import "RTXShakeViewController.h"
#import "RTXBapplicationInfoModel.h"
#import "ExpressInquiryViewController.h"
#import "DBHelpQueueManager.h"
#import "GreatActivityListViewController.h"
#import "VSUserLoginViewController.h"
#import "RTXUbanLeaseViewController.h"
#import "NewShareWebViewController.h"

@interface VSBaseViewController ()<VSPopBaseContextViewDelegate>
{
    //    VSView *_vm_slideMenu;
}


//@property (nonatomic, strong) VSView            *vm_slideMenu;


@property (nonatomic, strong) VSNetErrorView    *netErrorView;

@end

@implementation VSBaseViewController

#pragma mark -customService and oneKeyConsign
- (UIButton *)customServiceButton {
    if (!_customServiceButton) {
        _customServiceButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 64, self.view.frame.size.height - 49 - 49 - 70, 56, 60)];
        [_customServiceButton setImage:__IMAGENAMED__(@"btn_400_n") forState:UIControlStateNormal];
        [_customServiceButton setImage:__IMAGENAMED__(@"btn_400_h") forState:UIControlStateHighlighted];
        [_customServiceButton addTarget:self action:@selector(contactCustomService) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customServiceButton;
}

- (void)contactCustomService {
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        [[OneKeyConsignManager sharedOneKeyConsignManager] showCustomServiceView];
    } cancel:^{
        
    }];
}

- (UIButton *)oneKeyConsignButton {
    if (!_oneKeyConsignButton) {
        _oneKeyConsignButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 64, self.view.frame.size.height - 49 - 60, 56, 60)];
        [_oneKeyConsignButton setBackgroundImage:__IMAGENAMED__(@"btn_bg_yijianweituo_n") forState:UIControlStateNormal];
        [_oneKeyConsignButton setBackgroundImage:__IMAGENAMED__(@"btn_bg_yijianweituo_h") forState:UIControlStateHighlighted];
        
        UIButton *textButton = [[UIButton alloc] initWithFrame:CGRectMake(0, -5, 56, 60)];
        [textButton setTitle:@"一键\n委托" forState:UIControlStateNormal];
        [textButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [textButton.titleLabel setNumberOfLines:2];
        [textButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [textButton setTitleColor:_COLOR_HEX(0xffffff) forState:UIControlStateNormal];
        [textButton addTarget:self action:@selector(superOneKeyConsign) forControlEvents:UIControlEventTouchUpInside];
        [_oneKeyConsignButton addTarget:self action:@selector(superOneKeyConsign) forControlEvents:UIControlEventTouchUpInside];
        
        [_oneKeyConsignButton addSubview:textButton];
    }
    return _oneKeyConsignButton;
}

- (void)superOneKeyConsign {
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        [[OneKeyConsignManager sharedOneKeyConsignManager] showConsignView];
    } cancel:^{
        
    }];
}

#pragma mark end
- (void)dealloc
{
    DBLog(@"dealloc");
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSString *className = NSStringFromClass([self class]);
    [MobClick beginLogPageView:className];
    
    if (self.edgesForExtendedLayout == 0) {
        [self.customServiceButton setFrame:CGRectMake(__SCREEN_WIDTH__ - 64, self.view.frame.size.height - 49 - 49 - 70 - 60, 56, 60)];
        [self.oneKeyConsignButton setFrame:CGRectMake(__SCREEN_WIDTH__ - 64, self.view.frame.size.height - 49 - 60 - 60, 56, 60)];
    }
    
    if (self.shouldShouContactCustomService) {
        [self.view addSubview:self.customServiceButton];
    }
    if (self.shouldShowOneKeyConsign) {
        [self.view addSubview:self.oneKeyConsignButton];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    NSString *className = NSStringFromClass([self class]);
    [MobClick endLogPageView:className];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    //self.view.backgroundColor = kColor_MainBGColor;
    self.view.backgroundColor = _COLOR_HEX(0xf1f1f1);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIImage *navBarBackgroupImage = [self createImageWithColor:ColorWithHex(0xf9f9f9, 1.0)];
    [self.navigationController.navigationBar setBackgroundImage:[navBarBackgroupImage stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    if (self.navigationController.viewControllers.count > 1)
    {
        __weak typeof(self) t_self = self;
        [self useLeftBarItem:YES back:^{
            [t_self vs_leftButtonActon];
        }];
    }
    
    //    [self vs_showShareViewIcon];
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, MainWidth, 64.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextClearRect(context, rect);
    
    return myImage;
}

//- (void)vs_showShareViewIcon
//{
//    [self vm_slideMenu];
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //    [self.view bringSubviewToFront:self.vm_slideMenu];
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

- (void)userlogin:(LOGIN_BACK)backwhere popVc:(UIViewController *)vc animated:(BOOL)animated LoginSucceed:(void(^)(void))succeedBlock cancel:(void(^)(void))cancelBlock {
    //判断是否登录
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    if (!partyId) {
        VSUserLoginViewController *controller = [[VSUserLoginViewController alloc]init];
        controller.backWhere = backwhere;
        controller.succeedBlock = succeedBlock;
        controller.cancelBlock = cancelBlock;
        [controller setHidesBottomBarWhenPushed:YES];
//        [vc presentViewController:controller animated:YES completion:nil];
        if ([vc isKindOfClass:NSClassFromString(@"MeCenterViewController")]) {
            [vc.navigationController pushViewController:controller animated:NO];
        } else {
            [vc.navigationController pushViewController:controller animated:animated];
        }
    }else {
        succeedBlock();
    }
}

//用户是否登录
- (BOOL)isUserLogin{
    //判断是否登录
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    if (partyId) {
        return YES;
    }
    return NO;
}
- (NSString *)getUserPartyId{
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    return partyId;
}

//显示右侧按钮
- (void)vs_showRightButton:(BOOL)bshow
{
    if(bshow)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.vm_rightButton];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark -- action
//返回
- (void)vs_back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//左侧按钮点击事件
- (void)vs_leftButtonActon
{
    [self vs_back];
}

//右侧按钮点击事件
- (void)vs_rightButtonAction:(id)sender
{
    DBLog(@"右侧按钮点击了");
}

- (void)shareClicked
{
    VSShareDataSource *dataSource = _ALLOC_OBJ_(VSShareDataSource);
    
    dataSource.contentType      = SHARECONTENT_TYPE_PAGE;
    dataSource.shareImageUrl    = @"";
    dataSource.shareContent     = @"shareContent";
    dataSource.shareTitle       = @"分享标题";
    dataSource.shareInviteUrl   = @"http://www.baidu.com";
    
    //    dataSource
    [self.vm_shareContextView shareArray:[RTXShareContextView rtxShare] shareDataSource:dataSource];
    [self.vm_viewPop qb_show:self.vm_shareContextView toUIViewController:self];
}

- (void)shareClickedWithContent:(NSString *)content Title:(NSString *)title shareInviteUrl:(NSString *)shareInviteUrl
{
    VSShareDataSource *dataSource = _ALLOC_OBJ_(VSShareDataSource);
    
    dataSource.contentType      = SHARECONTENT_TYPE_PAGE;
    dataSource.shareImageUrl    = nil;
    
    dataSource.shareImage       = [UIImage imageNamed:@"myAPPicon"];
    dataSource.shareContent     = content;
    dataSource.shareTitle       = title;
    dataSource.shareInviteUrl   = shareInviteUrl;
    
    //    dataSource
    [self.vm_shareContextView shareArray:[RTXShareContextView rtxShare] shareDataSource:dataSource];
    [self.vm_viewPop qb_show:self.vm_shareContextView toUIViewController:self];
}

//跳转对应应用
- (void)toApplication:(id)model fromController:(UIViewController *)controller {
    
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
    //modify by Thomas [从O2O应用进B2C应用清空本地购物车，从B2C应用进O2O应用清空本地购物车]－－－start
    //    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    //    if ([userDef objectForKey:@"LastAppType"] && ![[userDef objectForKey:@"LastAppType"] isEqualToString:orderType] && ([orderType isEqualToString:SALES_ORDER_O2O_SALE] || [orderType isEqualToString:SALES_ORDER_B2C])) {
    //        //如存在且订单类型不相同(O2O订单和B2C订单)则清空本地购物车
    //        NSString *sqldeleteStr = nil;
    //        sqldeleteStr = [NSString stringWithFormat:@"DELETE from ld_cart"];
    //        [[DBHelpQueueManager shareInstance].rsFMDBQueue inDatabase:^(FMDatabase *db) {
    //            
    //            [db open];
    //            
    //            [db executeUpdate:sqldeleteStr];
    //            
    //            [db close];
    //            
    //            
    //        }];
    //    }
    //    
    //    [userDef setObject:orderType forKey:@"LastAppType"];//最后一次进的应用的类型
    //    [userDef synchronize];
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
        [controller.navigationController pushViewController:jswebvc animated:YES];
        
    }else if(visitType && [visitType isEqualToString:@"NATIVE"]){
        if ([visitkeyword isEqualToString:@"yyy"])
        {
            RTXShakeViewController *shakevc = [[RTXShakeViewController alloc] init];
            [controller.navigationController pushViewController:shakevc animated:YES];
        }else if ([visitkeyword isEqualToString:@"wyjkd"])
        {
            NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.sf-express.com/mobile/cn/sc/dynamic_functions/ship/ship.html?isappinstalled=1"]];
            jswebvc.webTitle = @"寄快递";
            [controller.navigationController pushViewController:jswebvc animated:YES];
        }else if ([visitkeyword isEqualToString:@"kdcx"])
        {
            NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://m.kuaidi100.com/"]];
            jswebvc.webTitle = @"快递查询";
            [controller.navigationController pushViewController:jswebvc animated:YES];
            
            //            ExpressInquiryViewController *eivc = [[ExpressInquiryViewController alloc]init];
            //            [controller.navigationController pushViewController:eivc animated:YES];
        }else if ([visitkeyword isEqualToString:@"jchd"])//精彩活动
        {
            GreatActivityListViewController *controller = [[GreatActivityListViewController alloc]init];
            [controller.navigationController pushViewController:controller animated:YES];
        }else  if ([visitkeyword isEqualToString:@"fwzl"])//房源信息
        {
            if ([self isUserlogin:LOGIN_BACK_DEFAULT popVc:controller animated:YES]) {
                RTXUbanLeaseViewController *uban = [[RTXUbanLeaseViewController alloc] init];
                [controller.navigationController pushViewController:uban animated:YES];
            }
        }
    }else{
        [controller.view showTipsView:@"请升级至最新版本查看！" afterDelay:1.5];
        return;
    }
}

#pragma mark -- title
//设置title文本
- (void)vs_setTitleText:(NSString*)titleText
{
    self.labelTitle.text            = titleText;
    self.labelTitle.textColor       = _COLOR_HEX(0x302f37);
    self.navigationItem.titleView   = self.labelTitle;
}

//设置title字体颜色
- (void)vs_setTitleColor:(UIColor*)titleColor
{
    [self.labelTitle setTextColor:titleColor];
}

- (void)vs_setTitleView:(UIView*)titleView
{
    self.navigationItem.titleView = titleView;
}

#pragma mark -- showloading
- (void)vs_showLoading
{
    [self.progressHUD show:YES];
}

- (void)vs_hideLoadingWithCompleteBlock:(MBProgressHUDCompletionBlock)completeBlock
{
    self.progressHUD.completionBlock = completeBlock;
    
    [self.progressHUD hide:YES];
}

#pragma mark -- NetErrorView
- (void)vs_showNetErrorView:(BOOL)show
{
    if(show)
    {
        [self.view addSubview:self.netErrorView];
        [self.netErrorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
            make.height.equalTo(@([[VSNetErrorView class] vp_height]));
            make.width.equalTo(@(168));
            
        }];
    }
    else
    {
        [_netErrorView removeFromSuperview];
    }
}

#pragma mark -- gesture
- (UITapGestureRecognizer*)vs_addTapGuesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
    tap.numberOfTapsRequired    = 1;
    tap.cancelsTouchesInView    = NO;
    [self.view addGestureRecognizer:tap];
    
    return tap;
}

- (void)doTap:(UITapGestureRecognizer*)sender
{
    if([self respondsToSelector:@selector(vp_doTap:)])
    {
        [self vp_doTap:sender];
    }
    else
    {
        [self.view endEditing:YES];
    }
}

#pragma mark -- getter
_GETTER_BEGIN(MBProgressHUD, progressHUD)
{
    _progressHUD        = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHUD.mode   = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_progressHUD];
}
_GETTER_END(progressHUD)

_GETTER_BEGIN(VSNetErrorView, netErrorView)
{
    __weak typeof(self) t_self = self;
    _netErrorView = [[VSNetErrorView alloc]initWithCallBack:^{
        
        [t_self.netErrorView removeFromSuperview];
        
        if([t_self respondsToSelector:@selector(vp_reloadNetData)])
        {
            [t_self vp_reloadNetData];
        }
        
    }];
}
_GETTER_END(netErrorView)

_GETTER_BEGIN(UILabel, labelTitle)
{
    _CLEAR_BACKGROUND_COLOR_(_labelTitle);
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    [self.labelTitle setTextColor:[UIColor whiteColor]];
    [self.labelTitle setTextAlignment:NSTextAlignmentCenter];
    self.labelTitle.font = [UIFont systemFontOfSize:20];  //设置文本字体与大小
}
_GETTER_END(labelTitle)

_GETTER_BEGIN(VSButton, vm_rightButton)
{
    _vm_rightButton = [VSButton buttonWithType:UIButtonTypeCustom];
    [_vm_rightButton setTitleColor:kColor_222222 forState:UIControlStateNormal];
    if (__SCREEN_WIDTH__ > 375) {
        [_vm_rightButton setFrame:_CGR(0, 0, 22, 20)];
        [_vm_rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
        [_vm_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    } else if (__SCREEN_WIDTH__ <= 375) {
        [_vm_rightButton setFrame:_CGR(0, 0, 22, 20)];
        [_vm_rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
        [_vm_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    }
    
    [_vm_rightButton addTarget:self action:@selector(vs_rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}
_GETTER_END(vm_rightButton)

//_GETTER_ALLOC_BEGIN(VSView, vm_slideMenu)
//{
//    [self.view addSubview:_vm_slideMenu];
//    [_vm_slideMenu setUserInteractionEnabled:YES];
//    [_vm_slideMenu setBackgroundColor:kColor_bbbbbb];
//    [_vm_slideMenu setAlpha:0.9];
//    [_vm_slideMenu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(@(-72));
//        make.right.equalTo(@(-6));
//        make.height.equalTo(@40);
//        make.width.equalTo(@40);
//    }];
//    
//    UIButton *top = [UIButton buttonWithType:UIButtonTypeCustom];
//    [top setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
//    [top addTarget:self action:@selector(shareClicked) forControlEvents:UIControlEventTouchUpInside];
//    [_vm_slideMenu addSubview:top];
//    [top mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(_vm_slideMenu.mas_width);
//        make.centerX.equalTo(_vm_slideMenu.mas_centerX);
//        make.centerY.equalTo(_vm_slideMenu.mas_centerY);
//        make.height.equalTo(_vm_slideMenu.mas_height);
//    }];
////    [top mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.width.equalTo(@50);
////        make.centerX.equalTo(_vm_slideMenu.mas_centerX);
////        make.centerY.equalTo(_vm_slideMenu.mas_centerY);
////        make.height.equalTo(@50);
////    }];
//}
//_GETTER_END(vm_slideMenu)

_GETTER_BEGIN(RTXShareContextView, vm_shareContextView)
{
    SHARETYPE array                         = [RTXShareContextView rtxShare];
    _vm_shareContextView                   = [[RTXShareContextView alloc] initWithHeight:[RTXShareContextView heightWithShareType:array]];
    _vm_shareContextView.delegate          = self;
    _vm_shareContextView.viewController    = self;
}
_GETTER_END(vm_shareContextView)

_GETTER_BEGIN(VSPopView, vm_viewPop)
{
    _vm_viewPop = [VSPopView popView];
}
_GETTER_END(vm_viewPop)

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
