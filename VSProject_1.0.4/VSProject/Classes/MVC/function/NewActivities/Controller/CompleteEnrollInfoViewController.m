//
//  CompleteEnrollInfoViewController.m
//  VSProject
//
//  Created by apple on 10/17/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CompleteEnrollInfoViewController.h"
#import "NewActivitiesManager.h"
#import "EnrollSucceedViewController.h"
#import "NewActivityDetailViewController.h"
#import "GreatActivityListViewController.h"

@interface CompleteEnrollInfoViewController () <UITextFieldDelegate>
{
    dispatch_group_t requestGroup;
    NewActivitiesManager *manager;
}
@end

@implementation CompleteEnrollInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"完善信息"];
    [self loadViewData];
    [self hideUseLeftBarItem];
    
    requestGroup = dispatch_group_create();
    manager = [[NewActivitiesManager alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}

- (void)loadViewData {
    [self.view1.layer setCornerRadius:5];
    [self.view1 setClipsToBounds:YES];
    
    [self.view2.layer setCornerRadius:5];
    [self.view2 setClipsToBounds:YES];
    
    [self.view3.layer setCornerRadius:5];
    [self.view3 setClipsToBounds:YES];
    
    [self.view4.layer setCornerRadius:5];
    [self.view4 setClipsToBounds:YES];
    
    [self.phoneTextField setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length + range.location > 1000 && ![string isEqualToString:@""]) {
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)nextStepAction:(id)sender {
    
//    //test
//    [self pageRouterAction:nil];
//    return;
    
    //调完善信息接口，获取订单号
    [self startRequest];
    
    if (self.nameTextField.text.length > 0 &&
        self.phoneTextField.text.length > 0 &&
        self.companyTextField.text.length > 0 &&
        self.workTextField.text.length > 0) {
        
        if (self.phoneTextField.text.length != 11 || ![self.phoneTextField.text hasPrefix:@"1"]) {
            [self.view showTipsView:@"请输入正确的手机号码"];
            return;
        }

        
        [self.nextButton setEnabled:NO];
        [self startRequest];
        [manager onCompleteEnrollInfo:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@""
                           activityId:self.a_model.activityId
                                 name:self.nameTextField.text
                               number:self.phoneTextField.text
                              company:self.companyTextField.text
                          customerJob:self.workTextField.text
                          userLoginId:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username?:@""
                              success:^(NSDictionary *responseObj) {
                                  NSError *err;
                                  NewActivityModel *actModel;
                                  actModel = [[NewActivityModel alloc] initWithDictionary:[responseObj valueForKey:@"activityInfo"] error:&err];
                                  self.a_model = actModel;
                                  
                                  NSDictionary *enrollment = [responseObj valueForKey:@"enrollment"];
                                  
                                  [self endRequest];
                                  [self pageRouterAction:enrollment];
                                  [self.nextButton setEnabled:YES];
                              }
                              failure:^(NSError *error) {
                                  [self endRequest];
                                  [self.view showTipsView:[error domain]];
                                  [self.nextButton setEnabled:YES];
                              }];
    } else {
        //去报名成功页
//        [self pageRouterAction:nil];
        [self.view showTipsView:@"请完善报名信息"];
    }
}

- (void)pageRouterAction:(NSDictionary *)enrollment {
    EnrollSucceedViewController *vc = [[EnrollSucceedViewController alloc] initWithNibName:@"EnrollSucceedViewController" bundle:nil];
    vc.a_model = self.a_model;
    vc.enrollment = enrollment;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)startRequest {
    
    dispatch_group_enter(requestGroup);
    
}
- (void)endRequest {
    
    dispatch_group_leave(requestGroup);
    
}

- (void)vs_back {
    NSLog(@"back action");
    //返回发现页要刷新
    VSBaseViewController *vcFx = [self.navigationController.viewControllers objectAtIndex:0];
    if ([vcFx isKindOfClass:[GreatActivityListViewController class]]) {
        ((GreatActivityListViewController *)vcFx).ifNeedRefresh = YES;
    }
    
    VSBaseViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
    if ([vc isKindOfClass:[NewActivityDetailViewController class]]) {
        ((NewActivityDetailViewController *)vc).a_model = self.a_model;
    }
    [self.navigationController popToViewController:vc animated:YES];
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
