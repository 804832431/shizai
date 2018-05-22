//
//  RTXCompleteAppointmentViewController.m
//  VSProject
//
//  Created by YaoJun on 15/10/29.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXCompleteAppointmentViewController.h"
#import "UINavigationController+HomePushVC.h"

@interface RTXCompleteAppointmentViewController () {

    NSTimer *countdownTimer;
}

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (assign, nonatomic) int leftSeconds;

@end

@implementation RTXCompleteAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"预约成功"];
    _backButton.layer.cornerRadius = 5.f;
    [_backButton addTarget:self action:@selector(toAppointment) forControlEvents:UIControlEventTouchUpInside];
    _leftSeconds = 6;
    
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
    [countdownTimer fire];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)vs_back{
    //pop回应用
    [countdownTimer invalidate];
    if (self.navigationController.viewControllers.count >= 2) {
        UIViewController * viewVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3];
        [self.navigationController popToViewController:viewVC animated:YES];
    }
}
- (void)backHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark -- action

- (void)countdown:(id)sender {
    
    _leftSeconds --;
    [_backButton setTitle:[NSString stringWithFormat:@"%d秒后返回“我的预约”",_leftSeconds] forState:UIControlStateNormal];
    if (_leftSeconds <= 0) {
        [countdownTimer invalidate];
        [self toAppointment];
    }
}

//Add by Thomas 睿天下RUI-797[]---start
- (void)backButtonSet{
    [countdownTimer invalidate];
    [_backButton setTitle:[NSString stringWithFormat:@"返回“我的预约”"] forState:UIControlStateNormal];
}
//Add by Thomas 睿天下RUI-797[]---start

- (void)toAppointment{
    //modify by Thomas 睿天下RUI-797[]---start
    [self backButtonSet];
    //modify by Thomas 睿天下RUI-797[]---end
    [self.navigationController vs_pushToAppointmentVC];
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
