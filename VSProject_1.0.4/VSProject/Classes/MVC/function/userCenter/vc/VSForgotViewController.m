//
//  VSForgotViewController.m
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSForgotViewController.h"
#import "UINavigationController+UserCenterPushVC.h"
#import "VSAccountInfoCell.h"
#import "VSAccountBtnActionCell.h"
#import "ForgetAccountInfoCell.h"
#import "ForgetAccountBottomCell.h"
#import "ForgetAccountbtnCell.h"
#import "ForgotResetViewController.h"
#import "LoginAccountModel.h"
#import "LDResisterManger.h"

#define COUNTTIME   60 //倒计时时间

@interface VSForgotViewController () {

    LDResisterManger *manger;
    int timecount;

}

@property (nonatomic, strong) LoginAccountModel *phoneItem;
@property (nonatomic, strong) LoginAccountModel *codeItem;

@end

@implementation VSForgotViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *navBarBackgroupImage = [self createImageWithColor:ColorWithHex(0xf9f9f9, 1.0)];
    [self.navigationController.navigationBar setBackgroundImage:[navBarBackgroupImage stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    
    if (_titleName) {
        [self vs_setTitleText:@"修改密码"];
        self.phoneItem.m_placeholder = @"请输入11位手机号";
        self.phoneItem.m_iconName = @"login_icon_phone_n";
        //修改密码带用户的注册手机号
        NSString *phoneNumber = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username;
        self.phoneItem.m_title =phoneNumber;
        self.dataSource = @[ @[self.phoneItem],@[self.codeItem],@[@"下一步"]];
    }else {
        [self vs_setTitleText:@"忘记密码"];
        self.dataSource = @[ @[self.phoneItem],@[self.codeItem],@[@"下一步"]];
    }
    
//    [self.vm_rightButton setTitle:@"找回" forState:UIControlStateNormal];
//    [self vs_showRightButton:YES];
    
    VSView *headView = _ALLOC_OBJ_WITHFRAME_(VSView, _CGR(0, 0, GetWidth(self.tableView), 75.3f));
    self.tableView.tableHeaderView = headView;
    
    manger = [[LDResisterManger alloc]init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    VSAccountBtnActionCell *btnCell = (VSAccountBtnActionCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    [self setBottomBtnEnable];
}

- (void)vs_rightButtonAction:(id)sender{}

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

#pragma mark 私有方法
#pragma mark --判断输入框内容
-(void)setBottomBtnEnable{
    VSAccountInfoCell *AccountbtnCell = (VSAccountInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ForgetAccountInfoCell *AccountInfoCell = (ForgetAccountInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    VSAccountBtnActionCell *btnCell = (VSAccountBtnActionCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    if ([AccountbtnCell vs_infoText].length > 0 || [AccountInfoCell vs_infoText].length > 0) {
        [btnCell btnEnabled :YES];
        
    }else{
        [btnCell btnEnabled :NO];
    }
    
}

#pragma mark action倒计时
-(BOOL)isArrivedTime{
    NSUserDefaults *timeDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *OldData = nil;
    if ([[timeDefaults objectForKey:@"YZMtimer"] isKindOfClass:[NSDate class]])
    {
        OldData = (NSDate *)[timeDefaults objectForKey:@"YZMtimer"];
        NSTimeInterval  timeInterval = [OldData timeIntervalSinceNow];
        timeInterval = -timeInterval;
        NSLog(@"%d",(int)timeInterval);
        if ((int)timeInterval >= COUNTTIME) {
            timecount = 1;
            return YES;
                    }
        else{
            return NO;
        }
    }
    return NO;
}

- (void)timerFired
{
    ForgetAccountbtnCell *cell = (ForgetAccountbtnCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];

    [cell.vm_getcodeBtn setTitle:[NSString stringWithFormat:@"%ds重新获取",timecount] forState:0];
    if (timecount <= 0) {
        [_timer invalidate];
        self.timer = nil;
        [cell.vm_getcodeBtn setTitle:@"获取验证码" forState:0];
//        cell.vm_getcodeBtn.backgroundColor = _COLOR_HEX(0x7dc67f);
        cell.vm_getcodeBtn.userInteractionEnabled = YES;
    }else{
        timecount--;
//        cell.vm_getcodeBtn.backgroundColor = [UIColor lightGrayColor];
        cell.vm_getcodeBtn.userInteractionEnabled = NO;
    }
}

#pragma mark TableviewControllerProtocol
//- (Class)vp_cellClass
//{
//    return [VSAccountInfoCell class];
//}
#pragma mark -- getter
_GETTER_BEGIN(NSArray, cellNameClasses)
{
    _cellNameClasses = @[
                         [VSAccountInfoCell class],
                         [ForgetAccountbtnCell class],
                         [VSAccountBtnActionCell class],
                         [ForgetAccountBottomCell class]
                         ];
}
_GETTER_END(cellNameClasses)

_GETTER_ALLOC_BEGIN(LoginAccountModel, phoneItem){
    self.phoneItem.m_placeholder = @"请输入11位手机号";
    self.phoneItem.m_iconName = @"login_icon_phone_n";
}
_GETTER_END(phoneItem)

_GETTER_ALLOC_BEGIN(LoginAccountModel, codeItem){
    self.codeItem.m_placeholder = @"请输入短信验证码";
    self.codeItem.m_iconName = @"login_icon_-verification_n";
}
_GETTER_END(codeItem)

_GETTER_ALLOC_BEGIN(NSTimer, timer){
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

_GETTER_END(timer)

#pragma mark ForgetAccountbtnCellDelegate
#pragma mark --输入框
- (BOOL)textField:(ForgetAccountbtnCell *)sender shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL isphone = [sender isKindOfClass:[VSAccountInfoCell class]];
    if (isphone) {
        // 用户名不为空则图标高亮
        if ([sender.vm_txtInfo.text length] == range.length && [string length] < 1) {
            self.phoneItem.m_iconName = @"login_icon_phone_n";
            [sender updateLeftImage:self.phoneItem.m_iconName];
        }
        else {
            self.phoneItem.m_iconName = @"login_icon_phone_h";
            [sender updateLeftImage:self.phoneItem.m_iconName];
        }
    }
    else {
        // 验证码不为空则图标高亮
        if ([sender.vm_txtInfo.text length] == range.length && [string length] < 1) {
            self.codeItem.m_iconName = @"login_icon_-verification_n";
            [sender updateLeftImage:self.codeItem.m_iconName];
        }
        else {
            self.codeItem.m_iconName = @"login_icon_-verification_h";
            [sender updateLeftImage:self.codeItem.m_iconName];
        }
    }
    
    if (isphone) {
        NSString *phoneNumber = [NSString stringWithFormat:@"%@%@",sender.vm_txtInfo.text,string];
        if (phoneNumber.length > 11 && string.length>0) {
            return NO;
        }else{
            return YES;
        }
    }else {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(ForgetAccountbtnCell *)sender {
    
    if ([sender isKindOfClass:[VSAccountInfoCell class]]) {
        if (![JudgmentUtil validateMobile:sender.vm_txtInfo.text]){//手机号
            [self.view showTipsView:@"请填写正确的手机号"];
        }
        self.phoneItem.m_iconName = @"login_icon_phone_n";
        [sender updateLeftImage:self.phoneItem.m_iconName];
    } else if ([sender isKindOfClass:[ForgetAccountbtnCell class]]) {
        if (sender.vs_infoText.length == 0){//验证马
            [self.view showTipsView:@"请输入验证码"];
        }
        self.codeItem.m_iconName = @"login_icon_-verification_n";
        [sender updateLeftImage:self.codeItem.m_iconName];
    }
    
    [self setBottomBtnEnable];
    
}

- (void)textFieldDidBeginEditing:(ForgetAccountbtnCell *)sender {
    if ([sender isKindOfClass:[VSAccountInfoCell class]]) {
        self.phoneItem.m_iconName = @"login_icon_phone_h";
        [sender updateLeftImage:self.phoneItem.m_iconName];
    } else if ([sender isKindOfClass:[ForgetAccountbtnCell class]]) {
        self.codeItem.m_iconName = @"login_icon_-verification_h";
        [sender updateLeftImage:self.codeItem.m_iconName];
    }
}

- (void)infotextFieldDidEndEditing:(ForgetAccountInfoCell *)sender {
    
    if (sender.vs_infoText.length == 0){//验证马
        [self.view showTipsView:@"请输入验证码"];
    }
    [self setBottomBtnEnable];
}

#pragma mark ForgetAccountbtnCellDelegate
#pragma mark --发送验证码
- (void)actionSendCaptcha:(ForgetAccountbtnCell *)sender {
    ForgetAccountbtnCell *cell = (ForgetAccountbtnCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (![JudgmentUtil validateMobile:[cell vs_infoText]]){//手机号
        [self.view showTipsView:@"请填写正确的手机号"];
    }else {//验证
        [self vs_showLoading];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[cell vs_infoText],@"cellphone", nil];
        [manger requestSendCaptcha:dic success:^(NSDictionary *responseObj) {
            //
            [self.view showTipsView:@"发送成功"];
            [self vs_hideLoadingWithCompleteBlock:nil];
        } failure:^(NSError *error) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self.view showTipsView:[error domain]];
            [_timer invalidate];
            _timer = nil;
            [sender.vm_getcodeBtn setTitle:@"获取验证码" forState:0];
//            sender.vm_getcodeBtn.backgroundColor = _COLOR_HEX(0x7dc67f);
            sender.vm_getcodeBtn.userInteractionEnabled = YES;
        }];
        timecount = COUNTTIME;
        NSUserDefaults *timeDefaults = [NSUserDefaults standardUserDefaults];
        NSDate * olddate=[NSDate date];
        [timeDefaults setObject:olddate forKey:@"YZMtimer"];
        [timeDefaults synchronize];
        [self.timer fire];

    }

}

#pragma mark VSAccountBtnActionCellDelegate
#pragma mark --提交按钮
- (void)vp_btnActionClicked:(VSAccountBtnActionCell*)sender{
    //TODO:ReSetPWD
    ForgetAccountbtnCell *cell = (ForgetAccountbtnCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ForgetAccountInfoCell *cell2 = (ForgetAccountInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];

    if (![JudgmentUtil validateMobile:[cell vs_infoText]]){//手机号
        [self.view showTipsView:@"请填写正确的手机号"];
    }else if ([cell2 vs_infoText].length == 0){//验证马
        [self.view showTipsView:@"请输入验证码"];
    }else {//验证
        [cell.vm_txtInfo resignFirstResponder];
        [cell2.vm_txtInfo resignFirstResponder];

        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[cell vs_infoText],@"cellphone",[cell2 vs_infoText],@"captcha", nil];
        [self vs_showLoading];
        [manger requestCheckCaptcha:dic success:^(NSDictionary *responseObj) {
            [self vs_hideLoadingWithCompleteBlock:^{
                ForgotResetViewController *fvc = _ALLOC_VC_CLASS_([ForgotResetViewController class]);
                fvc.phoneNumber = [cell vs_infoText];
                if (_titleName) {
                    fvc.titleName = _titleName;
                    [self.view showTipsView:@"修改成功"];
                }
                [self.navigationController pushViewController:fvc animated:YES];
            }];
        } failure:^(NSError *error) {
            [self vs_hideLoadingWithCompleteBlock:^{
                [self.view showTipsView:[error domain]];
            }];
        }];

    }
}

#pragma mark ForgetAccountBottomCellDelegate
#pragma mark --登录
- (void)vp_loginClicked:(ForgetAccountBottomCell*)sender {

    [self.navigationController popViewControllerAnimated:YES];
}
@end
