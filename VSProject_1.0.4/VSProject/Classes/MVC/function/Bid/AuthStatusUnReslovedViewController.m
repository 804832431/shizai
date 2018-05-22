//
//  AuthStatusUnReslovedViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import "AuthStatusUnReslovedViewController.h"
#import "TelPhoneCallAlertView.h"
#import "BidderManager.h"
#import "MyAuthHistoryViewController.h"
#import "AuthEnterpriseViewController.h"
#import "BCNetWorkTool.h"

@interface AuthStatusUnReslovedViewController ()

@end

@implementation AuthStatusUnReslovedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"企业信息"];
    
    [self setViews];
}

- (void)setViews {
    [self.contentView.layer setCornerRadius:10];
    [self.contentView setClipsToBounds:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setDataSource];
}

- (void)setDataSource {
    Bidder *bidder = [BidderManager shareInstance].authedEnterPrise.bidder;
    NSString *status = [BidderManager shareInstance].authedEnterPrise.authStatus;
    
    if([status isEqualToString:@"UNRESOLVED"]){
        [self.topBackGroundView setBackgroundColor:ColorWithHex(0xff4d4d, 1.0)];
        [self.authStatusLabel setText:@"认证中"];
        [self.failReasonLabel setHidden:YES];
        [self.failReasonHigh setConstant:0.01f];
        [self.failSeparatorLine setHidden:YES];
        [self.enterpriseNamelabel setText:bidder.enterpriseName];
        [self.userNameLabel setText:bidder.enterpriseLegalPerson];
        [self.enterpriseNumberLabel setText:bidder.enterpriseIdentity];
        
        [self.modifyButton setTitleColor:ColorWithHex(0xe6e6e6, 1.0) forState:UIControlStateNormal];
        [self.modifyButton.layer setCornerRadius:3.0f];
        [self.modifyButton.layer setBorderWidth:1.0f];
        [self.modifyButton.layer setBorderColor:ColorWithHex(0xe6e6e6, 1.0).CGColor];
        [self.modifyButton setEnabled:NO];
        
        [self.deleteButton setTitleColor:ColorWithHex(0xe6e6e6, 1.0) forState:UIControlStateNormal];
        [self.deleteButton.layer setCornerRadius:3.0f];
        [self.deleteButton.layer setBorderWidth:1.0f];
        [self.deleteButton.layer setBorderColor:ColorWithHex(0xe6e6e6, 1.0).CGColor];
        [self.deleteButton setEnabled:NO];
        
    }else if([status isEqualToString:@"PASS"]){
        
        [self.topBackGroundView setBackgroundColor:ColorWithHex(0x69faa3, 1.0)];
        [self.authStatusLabel setText:@"已认证"];
        [self.failReasonLabel setHidden:YES];
        [self.failReasonHigh setConstant:0.01f];
        [self.failSeparatorLine setHidden:YES];
        [self.enterpriseNamelabel setText:bidder.enterpriseName];
        [self.userNameLabel setText:bidder.enterpriseLegalPerson];
        [self.enterpriseNumberLabel setText:bidder.enterpriseIdentity];
        
        [self.deleteHigh setConstant:0.01f];
        [self.deleteSeparaterLine setHidden:YES];
        
        [self.modifyButton setHidden:YES];
        [self.deleteButton setHidden:YES];
        
    }else if([status isEqualToString:@"REJECT"]){
        [self.topBackGroundView setBackgroundColor:ColorWithHex(0x3e3e3e, 1.0)];
        [self.authStatusLabel setText:@"认证失败"];
        [self.failReasonLabel setText:bidder.failReason];
        [self.enterpriseNamelabel setText:bidder.enterpriseName];
        [self.userNameLabel setText:bidder.enterpriseLegalPerson];
        [self.enterpriseNumberLabel setText:bidder.enterpriseIdentity];
        [self.modifyButton.layer setCornerRadius:3.0f];
        [self.modifyButton.layer setBorderWidth:1.0f];
        [self.deleteButton.layer setCornerRadius:3.0f];
        
        [self.modifyButton.layer setCornerRadius:3.0f];
        [self.modifyButton.layer setBorderWidth:1.0f];
        [self.modifyButton.layer setBorderColor:ColorWithHex(0x959595, 1.0).CGColor];
        [self.modifyButton addTarget:self action:@selector(modifyAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.deleteButton.layer setCornerRadius:3.0f];
        [self.deleteButton.layer setBorderWidth:1.0f];
        [self.deleteButton.layer setBorderColor:ColorWithHex(0x959595, 1.0).CGColor];
        [self.deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)modifyAction {
    AuthEnterpriseViewController *vc = [[AuthEnterpriseViewController alloc] init];
    [vc setDataSource:[BidderManager shareInstance].authedEnterPrise.bidder];
    vc.isModify = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)deleteAction {
    [self vs_showLoading];
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *dic = @{
                          @"partyId" : partyId,
                          @"enterpriseId" : [BidderManager shareInstance].authedEnterPrise.bidder.id
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/del-enterprise/version/1.5.0" withSuccess:^(id callBackData) {
        
        [self.view showTipsView:@"删除成功"];
        
        [self vs_hideLoadingWithCompleteBlock:^{
            [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:1];
        }];
        
    } orFail:^(id callBackData) {
        [self.view showTipsView:[callBackData domain]];
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

- (IBAction)playCall:(id)sender {
    
    [TelPhoneCallAlertView  showWithTelPHoneNum:@"4008320087"];
    
}

@end
