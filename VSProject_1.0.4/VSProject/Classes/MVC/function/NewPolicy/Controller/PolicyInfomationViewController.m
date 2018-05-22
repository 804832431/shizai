//
//  PolicyInfomationViewController.m
//  VSProject
//
//  Created by apple on 11/7/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PolicyInfomationViewController.h"
#import "NewPolicyManager.h"

@interface PolicyInfomationViewController () <UITextFieldDelegate>
{
    dispatch_group_t requestGroup;
    NewPolicyManager *manager;
}

@end

@implementation PolicyInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self vs_setTitleText:@"信息填写"];
    [self loadViewData];
    
    requestGroup = dispatch_group_create();
    manager = [[NewPolicyManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

 - (void)loadViewData {
     [self.view1.layer setCornerRadius:5];
     [self.view1 setClipsToBounds:YES];
     
     [self.view2.layer setCornerRadius:5];
     [self.view2 setClipsToBounds:YES];
     
     [self.view3.layer setCornerRadius:5];
     [self.view3 setClipsToBounds:YES];
     
     [self.view4.layer setCornerRadius:5];
     [self.view4 setClipsToBounds:YES];
     
     [self.view5.layer setCornerRadius:5];
     [self.view5 setClipsToBounds:YES];
     
     [self.submitButton.layer setCornerRadius:5];
     [self.submitButton setClipsToBounds:YES];
     [self.submitButton setEnabled:NO];
     
     [self.contactPersonTextField setDelegate:self];
     [self.legalPersonTextField setDelegate:self];
     [self.areaNameTextField setDelegate:self];
     [self.enterpriseNameLabel setDelegate:self];
     [self.contactNumberTextField setDelegate:self];
 }

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self performSelector:@selector(verifyData) withObject:nil afterDelay:0.1];
    if (range.length + range.location > 1000 && ![string isEqualToString:@""]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)verifyData {
    if (self.enterpriseNameLabel.text.length > 0 &&
        self.areaNameTextField.text.length > 0 &&
        self.legalPersonTextField.text.length > 0 &&
        self.contactPersonTextField.text.length > 0 &&
        self.contactNumberTextField.text.length > 0) {
        
        if (self.contactNumberTextField.text.length == 11 && [self.contactNumberTextField.text hasPrefix:@"1"]) {
            [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.submitButton setEnabled:YES];
        } else {
            [self.submitButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.submitButton setEnabled:NO];
        }
    } else {
        [self.submitButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.submitButton setEnabled:NO];
    }
}

- (IBAction)sumbitAction:(id)sender {
    //调完善信息接口，获取订单号
    [self startRequest];
    
    if (self.enterpriseNameLabel.text.length > 0 &&
        self.areaNameTextField.text.length > 0 &&
        self.legalPersonTextField.text.length > 0 &&
        self.contactPersonTextField.text.length > 0 &&
        self.contactNumberTextField.text.length > 0) {
        
        if (self.contactNumberTextField.text.length != 11 || ![self.contactNumberTextField.text hasPrefix:@"1"]) {
            [self.view showTipsView:@"请输入正确的手机号码"];
            return;
        }
        
        [self startRequest];
        
        [manager onCompleteInfo:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@""
                       policyId:self.p_model.policyId
                 enterpriseName:self.enterpriseNameLabel.text
                       areaName:self.areaNameTextField.text
                    legalPerson:self.legalPersonTextField.text
                  contactPerson:self.contactPersonTextField.text
                  contactNumber:self.contactNumberTextField.text
                        success:^(NSDictionary *responseObj) {
                            [self.view showTipsView:@"您的申请已提交，请耐心等待结果"];
                            [self endRequest];
                            self.p_model.policyStatus = @"APPLIED";
                            [self.submitButton setEnabled:NO];
                            [self performSelector:@selector(popView) withObject:nil afterDelay:1.0];
                        }
                        failure:^(NSError *error) {
                            [self endRequest];
                            [self.view showTipsView:[error domain]];
                        }];
    } else {
        [self.view showTipsView:@"信息不完善"];
    }
}

- (void)popView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startRequest {
    
    dispatch_group_enter(requestGroup);
    
}
- (void)endRequest {
    
    dispatch_group_leave(requestGroup);
    
}

//- (void)vs_back {
//    NSLog(@"back action");
//    //返回发现页要刷新
//    VSBaseViewController *vcFx = [self.navigationController.viewControllers objectAtIndex:0];
//    if ([vcFx isKindOfClass:[GreatActivityListViewController class]]) {
//        ((GreatActivityListViewController *)vcFx).ifNeedRefresh = YES;
//    }
//    
//    VSBaseViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
//    if ([vc isKindOfClass:[NewActivityDetailViewController class]]) {
//        ((NewActivityDetailViewController *)vc).a_model = self.a_model;
//    }
//    [self.navigationController popToViewController:vc animated:YES];
//}

@end
