//
//  VSUserLoginViewController.m
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUserLoginViewController.h"
#import "UINavigationController+UserCenterPushVC.h"
#import "VSAccountBottomCell.h"
#import "LoginHeadView.h"
#import "VSUserLoginParm.h"
#import "LDResisterManger.h"
#import "CenterViewController.h"
#import "LoginAccountModel.h"
#import "DBHelpQueueManager.h"
#import "HomeBTabbarViewController.h"

@interface VSUserLoginViewController ()<VSAccountBottomCellDelegate> {

    LDResisterManger *manger;
}

@property (nonatomic, strong) LoginAccountModel *phoneItem;
@property (nonatomic, strong) LoginAccountModel *pwdItem;

@property (nonatomic, strong) UIView *headView;

@end

@implementation VSUserLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    [imageView setImage:__IMAGENAMED__(@"me_login_bg")];
//    [self.view insertSubview:imageView aboveSubview:self.view];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"me_login_bg"]];

    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(vs_back)];
    self.navigationController.navigationItem.leftBarButtonItem = leftItem;

    UIImage *navBarBackgroupImage = [self createImageWithColor:ColorWithHex(0xf9f9f9, 1.0)];
    [self.navigationController.navigationBar setBackgroundImage:[navBarBackgroupImage stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    
    manger = [[LDResisterManger alloc]init];
    [self vs_setTitleText:@"登录"];
    
    self.vm_submitType = ACCOUNT_SUBMIT_LOGIN;
    
//    LoginHeadView *headView = _ALLOC_OBJ_WITHFRAME_(LoginHeadView, _CGR(0, 0, GetWidth(self.tableView), 130));
    self.tableView.tableHeaderView = self.headView;

    self.dataSource = @[ @[self.phoneItem, self.pwdItem], @[@""], @[@"登录"] ];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self setHidesBottomBarWhenPushed:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setBottomBtnEnable];
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

- (UIView *)headView {
    
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.frame = CGRectMake(0, 0, MainWidth, 80.0f + 80.0f);
        _headView.backgroundColor = [UIColor clearColor];
        
        UIButton *backButton = [[UIButton alloc] init];
        backButton.frame = CGRectMake(25.0f, 30.0f, 12.0f, 20.0f);
        [backButton setBackgroundImage:[UIImage imageNamed:@"login_back_bg"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_headView addSubview:backButton];
        
        UIButton *bigButton = [[UIButton alloc] init];
        bigButton.frame = CGRectMake(25.0f, 30.0f, 40.0f, 40.0f);
        [bigButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_headView addSubview:bigButton];
        
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake((MainWidth - 125.0f)/2, 38.0f, 125.0f, 47.0f);
        iconImageView.image = [UIImage imageNamed:@"logo-"];
        [_headView addSubview:iconImageView];
    }
    return _headView;
}

#pragma mark -- Action

- (void)backAction:(UIButton *)button {
    
    [self vs_back];
}

- (void)vs_back {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.cancelBlock) {
        self.cancelBlock();
        return;
    }
    
    switch (_backWhere) {
            
        case LOGIN_BACK_HOME:{
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.tb.selectedIndex = 0;
        }
            break;
            
        case LOGIN_BACK_TAB_HOME:
        {
            HomeBTabbarViewController *homeB = [HomeBTabbarViewController shareInstance];
            homeB.tb.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
            
        case LOGIN_BACK_TAB_MANAGE:
        {
            HomeBTabbarViewController *homeB = [HomeBTabbarViewController shareInstance];
            homeB.tb.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;

        case LOGIN_BACK_CENTER:{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
            
            break;
            
        default:
            [self.navigationController popViewControllerAnimated:YES];
            break;
    }

    
}


#pragma mark -- VSAccountBtnActionCellDelegate
- (void)vp_btnActionClicked:(VSAccountBtnActionCell*)sender;
{
    [MobClick event:@"login"];

    //TODO:发送登陆请求
    VSAccountInfoCell *accountCell  = (VSAccountInfoCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    VSAccountInfoCell *passwordCell = (VSAccountInfoCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *t_account     = [accountCell vs_infoText];
    NSString *t_password    = [passwordCell vs_infoText];
    if (![JudgmentUtil validateMobile:t_account]){//手机号
        [self.view showTipsView:@"请填写正确的手机号"];
    }else if (![JudgmentUtil validatePassword:t_password]){//密码
        [self.view showTipsView:@"请输入6-15位字母或数字组合"];
    }
    else {
    
        [self vs_showLoading];
        NSDictionary *paraDic = [NSDictionary dictionaryWithObjectsAndKeys:t_account,@"username",t_password,@"password", nil];
        
        __weak typeof(self) weakSelf = self;
        [manger requestLogin:paraDic success:^(NSDictionary *responseObj) {
            [weakSelf vs_hideLoadingWithCompleteBlock:nil];
            [self.view showTipsView:@"登录成功"];
            //Modify by Thomas---购物车游客--start
            
            NSString *sqlStr = nil;
            ;
            sqlStr = [NSString stringWithFormat:@"UPDATE ld_cart SET userid = \'%@\' where userid = \'visitor\'",[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId];
            [[DBHelpQueueManager shareInstance]db_updateSql:sqlStr];
            
            //modify by Thomas [清空非当前用户的购物车数据] ---start
            NSString *sqldeleteotherStr = [NSString stringWithFormat:@"DELETE FROM ld_cart  where userid != \'%@\'",[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId];
            [[DBHelpQueueManager shareInstance]db_updateSql:sqldeleteotherStr];
            //modify by Thomas [清空非当前用户的购物车数据] ---end
            //Modify by Thomas---购物车游客--end
    
            NSDictionary *bidDic = [responseObj objectForKey:@"bidder"];
            if (bidDic && ![bidDic isEqual:[NSNull null]]) {
                NSString *companyName = [bidDic objectForKey:@"enterpriseName"];
                [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.companyName = companyName?:@"";
                [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder.contactName = [bidDic objectForKey:@"contactName"];
                [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder.contactNumber = [bidDic objectForKey:@"contactNumber"];
                [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder.enterpriseIdentity = [bidDic objectForKey:@"enterpriseIdentity"];
                [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder.enterpriseLegalPerson = [bidDic objectForKey:@"enterpriseLegalPerson"];
                [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder.enterpriseName = [bidDic objectForKey:@"enterpriseName"];
                [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder.id = [bidDic objectForKey:@"id"];
                [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];
            }
            
            [weakSelf loginSuccess];
        } failure:^(NSError *error) {
            [weakSelf.view showTipsView:[error domain]];
            [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        }];
        
    }
}
- (void)loginSuccess {
    [[NSNotificationCenter defaultCenter] postNotificationName:VS_LOGIN_SUCCEED object:nil];
    [self.navigationController popViewControllerAnimated:NO];
    if (self.succeedBlock) {
        self.succeedBlock();
        return;
    }
    
//    switch (_backWhere) {
//            
//        case LOGIN_BACK_HOME:{
//            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            app.tb.selectedIndex = 0;
//        }
//            break;
//           
//        case LOGIN_BACK_TAB_HOME:
//        {
//            HomeBTabbarViewController *homeB = [HomeBTabbarViewController shareInstance];
//            homeB.tb.selectedIndex = 0;
//            [self.navigationController popToRootViewControllerAnimated:YES];
//
//        }
//            break;
//
//        case LOGIN_BACK_TAB_MANAGE:
//        {
//            
//            HomeBTabbarViewController *homeB = [HomeBTabbarViewController shareInstance];
//
//            NSString *roleInCompany =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.roleInCompany;
//            if (roleInCompany && [roleInCompany isEqualToString:@"admin"]) {
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }else {
//                homeB.tb.selectedIndex = 0;
//            }
//            
//        }
//            break;
//
//        case LOGIN_BACK_CENTER:{
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//            
//            break;
//
//        default:
//            [self vs_back];
//            break;
//    }
}

#pragma mark -- VSAccountBottomCellDelegate
- (void)vp_registerClicked:(VSAccountBottomCell *)sender
{
    //TODO:注册
    
    [self.navigationController vs_pushToRegisterVC];
}

- (void)vp_forgotClicked:(VSAccountBottomCell *)sender
{
    //TODO:忘记密码
    [self.navigationController vs_pushToForgotVC];
}

#pragma mark -- VSAccountInfoCellDelegate

- (void)textFieldDidBeginEditing:(VSAccountInfoCell *)sender {
    BOOL isphone = [sender.vm_txtInfo.placeholder isEqualToString:@"请输入手机号"];
    if (isphone) {
        self.phoneItem.m_iconName = @"login_icon_phone_h";
        [sender updateLeftImage:self.phoneItem.m_iconName];
    }
    else {
        self.pwdItem.m_iconName = @"login_icon_--password_h";
        [sender updateLeftImage:self.pwdItem.m_iconName];
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)textFieldDidEndEditing:(VSAccountInfoCell *)sender {

    BOOL isphone = [sender.vm_txtInfo.placeholder isEqualToString:@"请输入手机号"];
    if (isphone) {
        self.phoneItem.m_iconName = @"login_icon_phone_n";
        [sender updateLeftImage:self.phoneItem.m_iconName];
    }
    else {
        self.pwdItem.m_iconName = @"login_icon_--password_n";
        [sender updateLeftImage:self.pwdItem.m_iconName];
    }
    [self setBottomBtnEnable];
    if (![JudgmentUtil validateMobile:sender.vm_txtInfo.text] && isphone){//手机号
        [self.view showTipsView:@"请填写正确的手机号"];
    }else if (![JudgmentUtil validatePassword:sender.vm_txtInfo.text] && !isphone){//密码
        [self.view showTipsView:@"请输入6-15位字母或数字组合"];
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}
- (BOOL)textField:(VSAccountInfoCell *)sender shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // textfiled输入字符串时icon高亮，否则灰色
    
    BOOL isphone = [sender.vm_txtInfo.placeholder isEqualToString:@"请输入手机号"];
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
        // 密码不为空则图标高亮
        if ([sender.vm_txtInfo.text length] == range.length && [string length] < 1) {
            self.pwdItem.m_iconName = @"login_icon_--password_n";
            [sender updateLeftImage:self.pwdItem.m_iconName];
        }
        else {
            self.pwdItem.m_iconName = @"login_icon_--password_h";
            [sender updateLeftImage:self.pwdItem.m_iconName];
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

-(void)setBottomBtnEnable{
    VSAccountInfoCell *AccountbtnCell = (VSAccountInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    VSAccountInfoCell *AccountInfoCell = (VSAccountInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    VSAccountBtnActionCell *btnCell = (VSAccountBtnActionCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    if (([AccountbtnCell vs_infoText] && [AccountbtnCell vs_infoText].length > 0) && ([AccountInfoCell vs_infoText] && [AccountInfoCell vs_infoText].length > 0)) {
        [btnCell btnEnabled :YES];
        
    }else{
        [btnCell btnEnabled :NO];
    }
    
}

#pragma mark -- getter
_GETTER_BEGIN(NSArray, cellNameClasses)
{
    _cellNameClasses = @[
                         [VSAccountInfoCell class],
                         [VSAccountBottomCell class],
                         [VSAccountBtnActionCell class]
                         ];
}
_GETTER_END(cellNameClasses)

_GETTER_ALLOC_BEGIN(LoginAccountModel, phoneItem){
    self.phoneItem.m_placeholder = @"请输入手机号";
    self.phoneItem.m_iconName = @"login_icon_phone_n";
}
_GETTER_END(phoneItem)

_GETTER_ALLOC_BEGIN(LoginAccountModel, pwdItem){
    self.pwdItem.m_placeholder = @"请输入密码";
    self.pwdItem.m_iconName = @"login_icon_--password_n";
    self.pwdItem.m_security = YES;
}
_GETTER_END(pwdItem)

- (void)didReceiveMemoryWarning
{
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
