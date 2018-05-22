//
//  VSUserRegisterViewController.m
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUserRegisterViewController.h"
#import "VSUserRegisterParm.h"

@interface VSUserRegisterViewController ()

@end

@implementation VSUserRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *navBarBackgroupImage = [self createImageWithColor:ColorWithHex(0xf9f9f9, 1.0)];
    [self.navigationController.navigationBar setBackgroundImage:[navBarBackgroupImage stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    
    [self vs_setTitleText:@"注册"];
    
    self.dataSource = @[ @[@"邮箱", [NSString stringWithFormat:@"密码(%@)", kpasswordNote]], @[@"注    册"] ];
    
    self.vm_submitType = ACCOUNT_SUBMIT_REGISTER;

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

#pragma mark -- VSAccountBtnActionCellDelegate
- (void)vp_btnActionClicked:(VSAccountBtnActionCell*)sender;
{
    //TODO:发送注册请求
    
    VSAccountInfoCell *accountCell  = (VSAccountInfoCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    VSAccountInfoCell *passwordCell = (VSAccountInfoCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *t_account     = [accountCell vs_infoText];
    NSString *t_password    = [passwordCell vs_infoText];
    if(t_account.length <= 0 || ![t_account isEmail])
    {
        [self.view showTipsView:@"请填写正确的登录邮箱" afterDelay:1.5];
        return;
    }
    else if(t_password.length <kminPassWord || t_password.length > kmaxPassWord)
    {
        [self.view showTipsView:@"请填写正确长度密码" afterDelay:1.5];
        return;
    }
    else
    {
        [self vs_showLoading];
       
    }
}

#pragma mark -- getter
_GETTER_BEGIN(NSArray, cellNameClasses)
{
    _cellNameClasses = @[
                         [VSAccountInfoCell class],
                         [VSAccountBtnActionCell class]
                         ];
}
_GETTER_END(cellNameClasses)

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
