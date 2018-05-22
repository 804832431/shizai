//
//  InviteViewController.m
//  VSProject
//
//  Created by certus on 16/3/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "InviteViewController.h"
#import "ManagementManger.h"

@interface InviteViewController ()

@property (strong, nonatomic) IBOutlet UITextField *phoneText;
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UIButton *sureButton;
@property (strong, nonatomic) ManagementManger *manger;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"邀请新成员"];
    [_sureButton addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Action

- (void)sureButton:(UIButton *)sender {
    
    [self requestInviteEmployee];
}

#pragma mark -- Request

- (void)requestInviteEmployee {
    
    if (_phoneText.text.length <= 0) {
        [self.view showTipsView:@"请填写员工电话！"];
        return;
    }

    if (_nameText.text.length <= 0) {
        [self.view showTipsView:@"请填写员工姓名！"];
        return;
    }
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";

    NSDictionary *dic = @{@"partyId":partyId,@"name":_nameText.text,@"userLoginId":_phoneText.text};
    [self vs_showLoading];
    [self.manger requestInviteEmployee:dic success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:@"邀请成功！" afterDelay:0.5f completeBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (ManagementManger *)manger {
    
    if (!_manger) {
        _manger = [[ManagementManger alloc]init];
    }
    return _manger;
}

@end
