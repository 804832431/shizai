//
//  SettingViewController.m
//  EmperorComing
//
//  Created by 姚君 on 15/8/31.
//  Copyright (c) 2015年 姚君. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"
#import "VersionViewController.h"
#import "SDPieProgressView.h"
#import "SDDemoItemView.h"
#import "Notification.h"
#import "SetingViewTableViewCell.h"
#define CELLHEIGHT  44

@interface SettingViewController () {

    SDPieProgressView *progressView;
    NSTimer *progressTimer;
    SDDemoItemView *demoView;
    CGFloat progress;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GOBACK(@"设置");
    self.view.backgroundColor = [UIColor redColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = (id<UITableViewDelegate>)self;
    tableView.dataSource = (id<UITableViewDataSource>)self;
    [self.view addSubview:tableView];
    

    UIButton *tuiChu_logIn_btn=[UIButton buttonWithType:0];
    tuiChu_logIn_btn.frame=CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    tuiChu_logIn_btn.backgroundColor=[UIColor colorWithHexString:@"#e25854" alpha:1];
    [tuiChu_logIn_btn setTitle:@"退出登录" forState:0];
    [tuiChu_logIn_btn addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tuiChu_logIn_btn];

}
-(void)tuichu{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"是否确定退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10087;
    [alertView show];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack {
    

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 4.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CELLHEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier=@"Cell";
      SetingViewTableViewCell *cell=(SetingViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        NSLog(@"进来好友列表");
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SetingViewTableViewCell" owner:nil options:nil] lastObject];
       
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    cell.backgroundColor = [UIColor clearColor];
    

//    if (indexPath.section == 0) {
//        cell.textLabel.text = @"退出登录";
//        UIImageView *cellBackView = [Gadget bgImageViewWith:Singel cellHeight:CELLHEIGHT];
//        [cell addSubview:cellBackView];
//        [cell insertSubview:cellBackView atIndex:0];
//
//    }
    if (indexPath.row == 0) {
        cell.name_lab.text = @"清空缓存";
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(4, cell.frame.size.height - 1, SCREEN_WIDTH - 8, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:lineView];
        
        UIImageView *cellBackView = [Gadget bgImageViewWith:TopFillet cellHeight:CELLHEIGHT];
        [cell addSubview:cellBackView];
        [cell insertSubview:cellBackView atIndex:0];
    }
    if (indexPath.row == 1) {
        cell.name_lab.text = @"关于";
        UIImageView *cellBackView = [Gadget bgImageViewWith:BottomFillet cellHeight:CELLHEIGHT];
        [cell addSubview:cellBackView];
        [cell insertSubview:cellBackView atIndex:0];
    }

    return cell;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 10087) {
        if (buttonIndex == 1) {
            //modifu by Thomas 退出登录－－－start
            //推送删别名标签
            [Notification removeUMPushAlias];
            [Notification removeUMPushTag];
            NSString *path = [LocalStorage userManagePath];
            NSFileManager *fileManager = [[NSFileManager alloc]init];
            if ([fileManager fileExistsAtPath:path]) {
                [fileManager removeItemAtPath:path error:nil];
            }
            PhoneNumberViewController *phone=[[PhoneNumberViewController alloc] init];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:phone];
            [self presentViewController:nav animated:NO completion:nil];
            //[self.navigationController popToRootViewControllerAnimated:NO];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"OUTLOGIN" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
            //modifu by Thomas 退出登录－－－end
        }
    }
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.section == 0) {
//        
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"是否确定退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alertView.tag = 10087;
//        [alertView show];
//        
//    }

    if (indexPath.row == 0) {

        if (demoView) {
            [demoView removeFromSuperview];
            [progressTimer invalidate];
        }
        demoView = [SDDemoItemView demoItemViewWithClass:[SDPieProgressView class]];
        demoView.frame = CGRectMake((SCREEN_WIDTH-100)/2, SCREEN_HEIGHT-250, 100, 100);
        [self.view addSubview:demoView];

        progress = 0;
        progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(progressSimulation) userInfo:self repeats:YES];
        [progressTimer fire];

    }
    if (indexPath.row == 1) {
        AboutViewController *controller = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

#pragma mark - Action

-(void)progressSimulation {
    
    if (progress < 1.0) {
        NSLog(@"progress=%f",progress);
        progress += 0.01;
        
        // 循环
        if (progress >= 1.0) {
            [progressTimer invalidate];
            [demoView removeFromSuperview];
        }
        
        demoView.progressView.progress = progress;
    }
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
