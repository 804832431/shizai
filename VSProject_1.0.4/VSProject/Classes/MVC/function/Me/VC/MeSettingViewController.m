//
//  MeSettingViewController.m
//  VSProject
//
//  Created by pangchao on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MeSettingViewController.h"
#import "SetingViewTableViewCell.h"
#import "VSForgotViewController.h"
#import "GuideViewController.h"
#import "AboutNewViewController.h"
#import "AgreementViewController.h"
#import "MeSettingTableViewCell.h"
#import "PersonalInformationViewController.h"
#import "ContactUsViewController.h"

#define CELLHEIGHT  50.0f

@interface MeSettingViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *groupArray;

@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation MeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = _COLOR_HEX(0xf1f1f1);
    [self vs_setTitleText:@"设置"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logoutButton];
    
    [self.tableView registerClass:[MeSettingTableViewCell class] forCellReuseIdentifier:@"MeSettingTableViewCell"];
}

- (NSMutableArray *)groupArray {
    
    if (!_groupArray) {
        _groupArray = [NSMutableArray array];
        
        [_groupArray addObject:@[@"用户设置", @"修改密码"]];
        [_groupArray addObject:@[@"关于时在", @"联系我们"]];
        //[_groupArray addObject:@[@"版本更新"]];
    }
    return _groupArray;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view)) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = _COLOR_HEX(0xf1f1f1);
        _tableView.delegate = (id<UITableViewDelegate>)self;
        _tableView.dataSource = (id<UITableViewDataSource>)self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (UIButton *)logoutButton {
    
    if (!_logoutButton) {
        _logoutButton = [[UIButton alloc] init];
        _logoutButton.frame = CGRectMake(12.0f, MainHeight - 44.0f - 60.0f - 50.0f, MainWidth - 12.0f*2, 50.0f);
        _logoutButton.backgroundColor = _COLOR_HEX(0xff3535);
        _logoutButton.layer.cornerRadius = 4.0f;
        [_logoutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

-(void)logout:(UIButton *)button {
    
    [MobClick event:@"logout"];

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"是否确定退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10087;
    [alertView show];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    NSLog(@"dealloc");
}

#pragma mark - UITableViewDataSource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [MeSettingTableViewCell getHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.00001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, MainWidth, 10.0f);
    headerView.backgroundColor = _COLOR_HEX(0xf3f3f3);
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sectionArray = [self.groupArray objectAtIndex:section];
    return sectionArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MeSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeSettingTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSArray *sectionArray = [self.groupArray objectAtIndex:indexPath.section];
    cell.titleLabel.text = [sectionArray objectAtIndex:indexPath.row];
    cell.tipsLabel.hidden = YES;
    if (indexPath.section == 2) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        cell.tipsLabel.text = [NSString stringWithFormat:@"V%@", app_Version];
        cell.tipsLabel.hidden = NO;
    }
    
    if (indexPath.row+1 == sectionArray.count) {
        cell.lineView.hidden = YES;
    }
    else {
        cell.lineView.hidden = NO;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10.0f;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 10087) {
        if (buttonIndex == 1) {
            //推送删别名标签
            [Notification removeJPushAlias];
            [VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo = nil;
            [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo = nil;
            [VSUserLogicManager shareInstance].userDataInfo.vm_defaultAdressInfo = nil;
            [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage = NO;
            [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];
            
            NSString *path = [LocalStorage userRegiesterPath];
            NSFileManager *fileManager = [[NSFileManager alloc]init];
            if ([fileManager fileExistsAtPath:path]) {
                [fileManager removeItemAtPath:path error:nil];
            }
            //            [[NSNotificationCenter defaultCenter]postNotificationName:@"requestLayout" object:nil];
            [self.navigationController popToRootViewControllerAnimated:NO];
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:VS_LOGOUT_SUCCEED object:nil];
                app.tb.selectedIndex = 0;
            });
            
        }
    }
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *sectionArray = [self.groupArray objectAtIndex:indexPath.section];
    if ([[sectionArray objectAtIndex:indexPath.row] isEqualToString:@"用户设置"]) {
        PersonalInformationViewController *controller = [[PersonalInformationViewController alloc] init];
        controller.personalDic = self.personalDic;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[sectionArray objectAtIndex:indexPath.row] isEqualToString:@"修改密码"]) {
        VSForgotViewController *fvc = _ALLOC_VC_CLASS_([VSForgotViewController class]);
        fvc.titleName = @"修改密码";
        [self.navigationController pushViewController:fvc animated:YES];
    }
    else if ([[sectionArray objectAtIndex:indexPath.row] isEqualToString:@"关于时在"]) {
        AboutNewViewController *controller = [[AboutNewViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[sectionArray objectAtIndex:indexPath.row] isEqualToString:@"联系我们"]) {
        ContactUsViewController *contactVC = [[ContactUsViewController alloc] init];
        [self.navigationController pushViewController:contactVC animated:YES];
    }
    else if ([[sectionArray objectAtIndex:indexPath.row] isEqualToString:@"版本更新"]) {
        // 不支持版本自动更新
        [self.view showTipsView:@"已经是最新版本"];
    }
}

@end
