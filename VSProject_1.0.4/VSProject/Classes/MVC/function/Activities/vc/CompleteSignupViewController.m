//
//  CompleteSignupViewController.m
//  VSProject
//
//  Created by certus on 16/2/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import "CompleteSignupViewController.h"
#import "MyActivityViewController.h"

@interface CompleteSignupViewController () {
    
    NSTimer *countdownTimer;
}

@property (assign, nonatomic) int leftSeconds;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation CompleteSignupViewController

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [countdownTimer invalidate];
    countdownTimer = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"报名成功"];
    _backButton.layer.cornerRadius = 5.f;
    [_backButton addTarget:self action:@selector(pushToMyActivityViewController) forControlEvents:UIControlEventTouchUpInside];
    _leftSeconds = 4;
    
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
    [countdownTimer fire];
    
}
- (void)vs_back {
    
    [countdownTimer invalidate];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushToMyActivityViewController {
    MyActivityViewController *vc =[[MyActivityViewController alloc]init];
    vc.backwhere = BACK_ROOT;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- action

- (void)countdown:(id)sender {
    
    _leftSeconds --;
    [_backButton setTitle:[NSString stringWithFormat:@"%d秒后跳转我的活动",_leftSeconds] forState:UIControlStateNormal];
    if (_leftSeconds <= 0) {
        [countdownTimer invalidate];
        [self pushToMyActivityViewController];
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
