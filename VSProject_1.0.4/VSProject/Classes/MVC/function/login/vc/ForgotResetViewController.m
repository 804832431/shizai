//
//  ForgotResetViewController.m
//  VSProject
//
//  Created by XuLiang on 15/10/29.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ForgotResetViewController.h"
#import "ForgetAccountBottomCell.h"
#import "LDResisterManger.h"
#import "CenterViewController.h"

@interface ForgotResetViewController () {

    LDResisterManger * manger;
}


@end

@implementation ForgotResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *navBarBackgroupImage = [self createImageWithColor:ColorWithHex(0xf9f9f9, 1.0)];
    [self.navigationController.navigationBar setBackgroundImage:[navBarBackgroupImage stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    
    manger = [[LDResisterManger alloc]init];
    
    /*--by Archer start--*/
    if (_titleName) {
        [self vs_setTitleText:@"修改密码"];
        //修改密码带用户的注册手机号
        _phoneNumber = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username;
        self.dataSource = @[ @[self.passmodel, self.suremodel], @[@"完成"] ];

    }else {
        [self vs_setTitleText:@"忘记密码"];
        self.dataSource = @[ @[self.passmodel, self.suremodel], @[@"完成"], @[@""] ];
    }
    /*--by Archer end--*/

    VSView *headView = _ALLOC_OBJ_WITHFRAME_(VSView, _CGR(0, 0, GetWidth(self.tableView), 14));
    self.tableView.tableHeaderView = headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)textFieldDidBeginEditing:(VSAccountInfoCell *)sender {
    if ([sender.vm_txtInfo.placeholder isEqualToString:@"请确认密码："]) {
        self.suremodel.m_iconName = @"login_icon_--password_h";
        [sender updateLeftImage:self.suremodel.m_iconName];
        
    }else {
        self.passmodel.m_iconName = @"login_icon_--password_h";
        [sender updateLeftImage:self.passmodel.m_iconName];
    }
}

- (void)textFieldDidEndEditing:(VSAccountInfoCell *)sender {

    if ([sender.vm_txtInfo.placeholder isEqualToString:@"请确认密码："]) {
        VSAccountInfoCell *cell1 = (VSAccountInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSString *password1 = [cell1 vs_infoText];
        NSString *password2 = [sender vs_infoText];

        if (![password1 isEqualToString:password2]) {
            [self.view showTipsView:@"密码不一致"];
        }
        
        self.suremodel.m_iconName = @"login_icon_--password_n";
        [sender updateLeftImage:self.suremodel.m_iconName];
        
    }else {
        NSString *password1 = [sender vs_infoText];
        if (![JudgmentUtil validatePassword:password1]) {
            [self.view showTipsView:@"请输入6-15位字母或数字组合"];
        }

        self.passmodel.m_iconName = @"login_icon_--password_n";
        [sender updateLeftImage:self.passmodel.m_iconName];
    }
}

- (BOOL)textField:(VSAccountInfoCell *)sender shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if (range.location == 15 && ![string isEqualToString:@""]) {
        return NO;
    }
    
    if ([sender.vm_txtInfo.placeholder isEqualToString:@"请确认密码："]) {
        // 确认密码不为空则高亮
        if ([sender.vm_txtInfo.text length] == range.length && [string length] < 1) {
            self.suremodel.m_iconName = @"login_icon_--password_n";
            [sender updateLeftImage:self.suremodel.m_iconName];
        }
        else {
            self.suremodel.m_iconName = @"login_icon_--password_h";
            [sender updateLeftImage:self.suremodel.m_iconName];
        }
    }else {
        // 新密码不为空则高亮
        if ([sender.vm_txtInfo.text length] == range.length && [string length] < 1) {
            self.suremodel.m_iconName = @"login_icon_--password_n";
            [sender updateLeftImage:self.suremodel.m_iconName];
        }
        else {
            self.suremodel.m_iconName = @"login_icon_--password_h";
            [sender updateLeftImage:self.suremodel.m_iconName];
        }
    }
    
    return YES;
}

//下一步
- (void)vp_btnActionClicked:(VSAccountBtnActionCell*)sender {

    //TODO:下一步
    VSAccountInfoCell *cell1 = (VSAccountInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    VSAccountInfoCell *cell2 = (VSAccountInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    NSString *password1 = [cell1 vs_infoText];
    NSString *password2 = [cell2 vs_infoText];
    if (![JudgmentUtil validatePassword:password1]) {
        [self.view showTipsView:@"请输入6-15位字母或数字组合"];
    }else if (![password1 isEqualToString:password2]) {
        [self.view showTipsView:@"密码不一致"];
    }else {
    
        [self vs_showLoading];
        __weak typeof(self) weakself = self;
        NSDictionary *paraDic = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumber,@"username",password1,@"newPassword", nil];
        [manger requestForgetPassword:paraDic success:^(NSDictionary *responseObj) {

            if (responseObj) {

                [self resetPasswordSuccess];
            }
            [weakself vs_hideLoadingWithCompleteBlock:nil];
        } failure:^(NSError *error) {
            [weakself.view showTipsView:[error domain]];
            [weakself vs_hideLoadingWithCompleteBlock:nil];
        }];
    }
}

- (void)resetPasswordSuccess {
    VSAccountInfoCell *cell1 = (VSAccountInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *password1 = [cell1 vs_infoText];

    if (_titleName) {
        [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.password = password1;
        [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];

        NSArray *viewContrllers = self.navigationController.viewControllers;
        [self.navigationController popToViewController:[viewContrllers objectAtIndex:viewContrllers.count-3] animated:YES];
    }else {
        //忘记密码后重新登录

        NSDictionary *paraDic = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumber,@"username",password1,@"password", nil];
        
        __weak typeof(self) weakself = self;
        [weakself.view showTipsView:@"密码重置成功，稍后将自动登录！" afterDelay:0.6f completeBlock:^{
            [self vs_showLoading];
        }];
        [manger requestLogin:paraDic success:^(NSDictionary *responseObj) {
            [weakself vs_hideLoadingWithCompleteBlock:nil];

            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.tb.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            [weakself vs_hideLoadingWithCompleteBlock:nil];
            [weakself.view showTipsView:[error domain] afterDelay:0.6f completeBlock:^{
                AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                app.tb.selectedIndex = 0;
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }];
    }

}
- (void)vp_loginClicked:(ForgetAccountBottomCell*)sender {
    //TODO:账号登录
    
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[viewcontrollers objectAtIndex:viewcontrollers.count-3] animated:YES];
}


#pragma mark -- getter
_GETTER_BEGIN(NSArray, cellNameClasses)
{
    _cellNameClasses = @[
                         [VSAccountInfoCell class],
                         [VSAccountBtnActionCell class],
                         [ForgetAccountBottomCell class]
                         ];
}
_GETTER_END(cellNameClasses)

_GETTER_ALLOC_BEGIN(LoginAccountModel, passmodel){
    _passmodel.m_placeholder = @"请输入新密码：";
    _passmodel.m_iconName = @"login_icon_--password_n";
    _passmodel.m_security = YES;
}
_GETTER_END(passmodel)

_GETTER_ALLOC_BEGIN(LoginAccountModel, suremodel){
    _suremodel.m_placeholder = @"请确认密码：";
    _suremodel.m_iconName = @"login_icon_--password_n";
    _suremodel.m_security = YES;
}
_GETTER_END(suremodel)

@end
