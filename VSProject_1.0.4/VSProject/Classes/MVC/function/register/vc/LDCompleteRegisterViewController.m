//
//  LDCompleteRegisterViewController.m
//  VSProject
//
//  Created by YaoJun on 15/10/29.
//  Copyright © 2015年 user. All rights reserved.
//

#import "LDCompleteRegisterViewController.h"

@interface LDCompleteRegisterViewController () {

    NSTimer *countdownTimer;
}

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (assign, nonatomic) int leftSeconds;

@end

@implementation LDCompleteRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"注册"];
    _backButton.layer.cornerRadius = 5.f;
    [_backButton addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    _leftSeconds = 6;
    
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
    [countdownTimer fire];
}

- (void)vs_back {

    [countdownTimer invalidate];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.tb.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backHome{

    [self vs_back];
}
#pragma mark -- action

- (void)countdown:(id)sender {
    
    _leftSeconds --;
    [_backButton setTitle:[NSString stringWithFormat:@"%d秒后返回首页",_leftSeconds] forState:UIControlStateNormal];
    if (_leftSeconds <= 0) {
        [countdownTimer invalidate];
        [self backHome];
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
