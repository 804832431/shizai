//
//  RTXShakeViewController.m
//  VSProject
//
//  Created by XuLiang on 15/11/14.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXShakeViewController.h"
#import "RTXShakeView.h"
#import "RTXRandomProductInfoModel.h"
#import "UINavigationController+HomePushVC.h"
#import "MessageViewController.h"
#import "VSUserLoginViewController.h"
#import "MessageManager.h"

@interface RTXShakeViewController () <RTXShakeViewDelegate>

@property(nonatomic, strong) RTXShakeView *shakeView;

@end

@implementation RTXShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vs_setTitleText:@"摇一摇"];
    [self recoverRightButton];
    [self.view addSubview:self.shakeView];
    [_shakeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    [self vs_showRightButton:YES];

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self requesthaveNewMessage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requesthaveNewMessage {
    
    MessageManager *messageManager = [[MessageManager alloc]init];
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    if ([partyId isEmptyString]) {
        return;
    }
    [messageManager requesthaveNewMessage:nil success:^(NSDictionary *responseObj) {
        
        NSNumber *hasNewMessage = [responseObj objectForKey:@"hasNewMessage"];
        [self vs_showRightButton:YES];
        [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage = hasNewMessage.boolValue;
        [self recoverRightButton];
    } failure:^(NSError *error) {
        //
    }];
}

- (void)message {
    
    //判断是否登录
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        MessageViewController *controller = [[MessageViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    } cancel:^{
        
    }];
}

-(void)recoverRightButton {
    
    self.navigationItem.rightBarButtonItem =nil;
    [self vs_showRightButton:YES];
    
    BOOL havNewMessage = [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage;
    if (havNewMessage) {
        [self.vm_rightButton setImage:[UIImage imageNamed:@"more_red"] forState:0];
    }else {
        [self.vm_rightButton setImage:[UIImage imageNamed:@"more"] forState:0];
    }
    
}
//重写右侧按钮点击事件
- (void)vs_rightButtonAction:(id)sender
{
    NSArray *titles = @[@"个人首页",@"消息"];
    NSArray *images = @[@"home_icon",@"message_icon"];
    BOOL havNewMessage = [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage;
    if (havNewMessage) {
        images = @[@"home_icon",@"message_icon_red"];
    }else {
        images = @[@"home_icon",@"message_icon"];
    }

    PopoverView *tmppopoverView = [[PopoverView alloc] initWithPoint:CGPointMake(MainWidth - self.vm_rightButton.frame.size.width, self.navigationController.navigationBar.frame.origin.y + self.vm_rightButton.frame.origin.y + self.vm_rightButton.frame.size.height - 1.0f) titles:titles images:images];
    tmppopoverView.selectRowAtIndex = ^(NSInteger index){
        if (index == 0) {
            //返回首页
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.tb.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if(index == 1){
            //消息
            [self message];
        }else {
            NSLog(@"have no action");
        }
        
    };
    [tmppopoverView show];
}
#pragma mark - 实现相应的响应者方法
//- (BOOL)canBecomeFirstResponder {//默认是NO，所以得重写此方法，设成YES
//    return YES;
//}
/** 开始摇一摇 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionBegan");
    
    
}

/** 摇一摇结束（需要在这里处理结束后的代码） */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // 不是摇一摇运动事件
    if (motion != UIEventSubtypeMotionShake) return;
    [self.shakeView openShake];
    NSLog(@"motionEnded");
    
    
}

/** 摇一摇取消（被中断，比如突然来电） */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionCancelled");
}
#pragma mark --Delegate

- (void)toProductDetail:(NSString *)str{
    [self.navigationController vs_pushToJsWebVC:str];
}

_GETTER_ALLOC_BEGIN(RTXShakeView, shakeView)
{
    //设代理
    _shakeView.m_delegate = self;
    //定义block
    __weak RTXShakeViewController *weakSelf = self;
    [_shakeView setRtxShakeViewBlock:^(RTXShakeView *view) {
        __strong RTXShakeViewController *strongSelf = weakSelf;
        //请求
        [strongSelf vs_showLoading];
        [[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId = @"SALES_ORDER_B2C";
        [[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId = @"Gshop";
        [[RTXMotionLogicManager shareInstance] vs_motionWithBaseModel:[RTXRandomProductInfoModel class] success:^(id result, id data) {
            [strongSelf vs_hideLoadingWithCompleteBlock:^{
                //0.5s后结束动画,页面切换为领券
                [view closeShake];
                [view vp_updateUIWithModel:data];
                //                [strongSelf.view showTipsView:@"成功！" afterDelay:1.5];
            }];
        } failed:^(id result, id data) {
            [strongSelf vs_hideLoadingWithCompleteBlock:^{
                [view closeShake];
                [view vp_updateUIWithModel:data];
                [strongSelf.view showTipsView:@"摇一摇，请换个姿势重试！" afterDelay:0.5];
            }];
        }];
        
    }];
}
_GETTER_END(shakeView)
@end
