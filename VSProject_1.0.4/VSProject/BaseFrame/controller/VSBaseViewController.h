//
//  VMBaseViewController.h
//  beautify
//
//  Created by xiangying on 14-11-12.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import "PopoverView.h"
#import "VSPopView.h"
#import "RTXShareContextView.h"
#import "OneKeyConsignManager.h"

@protocol VSBaseViewControllerProtocol <NSObject>

@optional
- (void)vp_reloadNetData;

- (void)vp_doTap:(UITapGestureRecognizer*)sender;

@end


@interface VSBaseViewController : UIViewController <VSBaseViewControllerProtocol>

@property (nonatomic, assign) BOOL shouldShouContactCustomService;

@property (nonatomic, assign) BOOL shouldShowOneKeyConsign;

@property (nonatomic, strong) UIButton *customServiceButton;

@property (nonatomic, strong) UIButton *oneKeyConsignButton;

@property (nonatomic, strong) RTXShareContextView *vm_shareContextView;//@property (nonatomic, strong) VSShareContextView *vm_shareContextView;

@property (nonatomic, strong) VSPopView *vm_viewPop;//vm_viewPop


@property (nonatomic, strong) MBProgressHUD     *progressHUD;

@property (nonatomic, strong) UILabel           *labelTitle;

#pragma mark -- property
_PROPERTY_NONATOMIC_STRONG(VSButton, vm_rightButton);   //右侧按钮
//用户是否登录
- (BOOL)isUserLogin;
- (NSString *)getUserPartyId;
//- (BOOL)isUserlogin:(LOGIN_BACK)backwhere popVc:(UIViewController *)vc animated:(BOOL)animated;
- (void)userlogin:(LOGIN_BACK)backwhere popVc:(UIViewController *)vc animated:(BOOL)animated LoginSucceed:(void(^)(void))succeedBlock cancel:(void(^)(void))cancelBlock;
//全局导航页
- (void)HomeNav;
//分享页
- (void)shareClicked;
- (void)shareClickedWithContent:(NSString *)content Title:(NSString *)title shareInviteUrl:(NSString *)shareInviteUrl;
//显示右侧按钮
- (void)vs_showRightButton:(BOOL)bshow;

#pragma mark -- action
//返回
- (void)vs_back;

//左侧按钮点击事件
- (void)vs_leftButtonActon;

//右侧按钮点击事件
- (void)vs_rightButtonAction:(id)sender;

//跳转对应应用
- (void)toApplication:(id)model fromController:(UIViewController *)controller;

#pragma mark -- title
//设置title文本
- (void)vs_setTitleText:(NSString*)titleText;

//设置title字体颜色
- (void)vs_setTitleColor:(UIColor*)titleColor;

- (void)vs_setTitleView:(UIView*)titleView;

#pragma mark -- loading
- (void)vs_showLoading;

- (void)vs_hideLoadingWithCompleteBlock:(MBProgressHUDCompletionBlock)completeBlock;

#pragma mark -- errorView
- (void)vs_showNetErrorView:(BOOL)show;

#pragma mark -- gesture
//添加tap手势
- (UITapGestureRecognizer*)vs_addTapGuesture;

@end
