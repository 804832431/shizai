//
//  SettingViewController.m
//  EmperorComing
//
//  Created by certus on 15/8/31.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import "SettingViewController.h"
#import "SetingViewTableViewCell.h"
#import "VSForgotViewController.h"
#import "GuideViewController.h"
#import "AboutViewController.h"
#import "AgreementViewController.h"

#define CELLHEIGHT  48


@interface SettingViewController () {
    
    NSTimer *progressTimer;
    CGFloat progress;
    NSArray *imageArray;
    NSArray *titileSrray;
    UITableView *tableView;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self vs_setTitleText:@"设置"];
    self.view.backgroundColor = [UIColor redColor];
    
    imageArray = @[@"changePassword",@"phone_setting",@"about",@"version",@"qyystk",@"mzsm"];
    titileSrray = @[@"修改密码",@"服务热线：400-832-0087",@"关于时在",@"当前版本",@"企业隐私条款",@"免责声明"];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, MainWidth, MainHeight) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = (id<UITableViewDelegate>)self;
    tableView.dataSource = (id<UITableViewDataSource>)self;
    [self.view addSubview:tableView];
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-480+150)];
    UIButton *tuiChu_logIn_btn=[UIButton buttonWithType:0];
    tuiChu_logIn_btn.frame=CGRectMake(10, MainHeight-480, MainWidth-20, 40);
    tuiChu_logIn_btn.backgroundColor= _COLOR_HEX(0x258567);
    tuiChu_logIn_btn.layer.cornerRadius = 5;
    [tuiChu_logIn_btn setTitle:@"退出当前账号" forState:0];
    [tuiChu_logIn_btn setTitle:@"退出当前账号" forState:1];
    [tuiChu_logIn_btn addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:tuiChu_logIn_btn];
    
    UILabel *copyRightLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, OffSetY(tuiChu_logIn_btn)+43, MainWidth-40, 50)];
    copyRightLabel.backgroundColor = [UIColor clearColor];
    copyRightLabel.textAlignment =NSTextAlignmentCenter;
    copyRightLabel.textColor = _COLOR_HEX(0x666666);
    copyRightLabel.font = FONT_TITLE(10);
    copyRightLabel.numberOfLines = 3;
    copyRightLabel.text = @"北京睿天下新媒体信息技术有限公司  版权所有\nCopyright@2011-2015 Ruitianxia.\nAll Rights Reserved.";
    [footer addSubview:copyRightLabel];
    
    tableView.tableFooterView = footer;
    
}
-(void)tuichu{
    [MobClick event:@"logout"];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"是否确定退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10087;
    [alertView show];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    [tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    NSLog(@"dealloc");
}

//拨打电话
- (void)callPhoneNunber:(NSString *)phoneNunber {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneNunber]]];
}

#pragma mark - UITableViewDataSource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CELLHEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier=@"Cell";
    SetingViewTableViewCell *cell=(SetingViewTableViewCell *)[tableView1 dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SetingViewTableViewCell" owner:nil options:nil] lastObject];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.settingimageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    cell.name_lab.text = [titileSrray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 3) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        [cell.subLabel setText:[NSString stringWithFormat:@"V%@",app_Version]];
        [cell.arrow setHidden:YES];
        [cell.subLabel setHidden:NO];
    }else {
        [cell.arrow setHidden:NO];
        [cell.subLabel setHidden:YES];
    }
    
    return cell;
    
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
                 app.tb.selectedIndex = 0;
            });
           
        }
    }
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        VSForgotViewController *fvc = _ALLOC_VC_CLASS_([VSForgotViewController class]);
        fvc.titleName = @"修改密码";
        [self.navigationController pushViewController:fvc animated:YES];
    }
    
    if (indexPath.row == 1) {
        [self callPhoneNunber:@"400-832-0087"];
    }
    if (indexPath.row == 2) {
        
        GuideViewController *firstView=[[GuideViewController alloc]init];
        firstView.needDisapperButton = NO;
        [self.navigationController pushViewController:firstView animated:YES];
    }
    if (indexPath.row == 3) {
        
        //        AboutViewController *controller=[[AboutViewController alloc]init];
        //        [self.navigationController pushViewController:controller animated:YES];
        
    }
    if (indexPath.row == 4) {
        
        AgreementViewController *controller=[[AgreementViewController alloc]init];
        controller.titleName = @"企业隐私条款";
        controller.resourceName = @"EnterprisePrivacyClause";
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    if (indexPath.row == 5) {
        
        AgreementViewController *controller=[[AgreementViewController alloc]init];
        controller.titleName = @"免责声明";
        controller.resourceName = @"Disclaimer";
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    
}

#pragma mark - Action

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
