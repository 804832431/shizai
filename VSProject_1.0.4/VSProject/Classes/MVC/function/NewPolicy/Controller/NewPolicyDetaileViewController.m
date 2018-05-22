//
//  NewPolicyDetaileViewController.m
//  VSProject
//
//  Created by apple on 11/6/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "NewPolicyDetaileViewController.h"
#import "NewPolicyManager.h"
#import "PolicyInfomationViewController.h"
#import "BidderManager.h"
#import "AuthEnterpriseViewController.h"
#import "AuthStatusUnReslovedViewController.h"
#import "BCNetWorkTool.h"
#import "NSObject+MJKeyValue.h"

@interface NewPolicyDetaileViewController ()
{
    dispatch_group_t requestGroup;
    NewPolicyManager *manager;
}

_PROPERTY_NONATOMIC_STRONG(UIButton, collectButton);
_PROPERTY_NONATOMIC_STRONG(UIButton, applyButton);
_PROPERTY_NONATOMIC_STRONG(UIView, bottomBar);

@end

@implementation NewPolicyDetaileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.webTitle = @"政策详情";
    
    self.shouldShouContactCustomService = NO;
    
    [self vs_setTitleText:self.webTitle];
    
    [self.navigationController.navigationBar addSubview:self.collectButton];
    
    [self.view addSubview:self.bottomBar];
    requestGroup = dispatch_group_create();
    manager = [[NewPolicyManager alloc] init];
}

- (void)webViewFinishLoad {
    BOOL canGoBack = [self webViewCanGoBack];
    if (canGoBack) {
        [self.bottomBar setHidden:YES];
        [self.collectButton setHidden:YES];
        [self vs_showRightButton:NO];
//        [self vs_setTitleText:@"公示结果"];
    } else {
        [self.bottomBar setHidden:NO];
        [self.collectButton setHidden:NO];
        [self vs_showRightButton:YES];
//        [self vs_setTitleText:@"政策详情"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewFinishLoad) name:NoticeName_WebViewDidLoadMsg object:nil];
    [self.collectButton setHidden:NO];
    [self.bottomBar setHidden:NO];
    [self vs_showRightButton:YES];
    [self.vm_rightButton setImage:[UIImage imageNamed:@"btn_nav_share_n"] forState:UIControlStateNormal];
    [self.vm_rightButton setImage:[UIImage imageNamed:@"btn_nav_share_h"] forState:UIControlStateHighlighted];
    
    [self refresh];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectButton setHidden:YES];
    [self.collectButton removeFromSuperview];
    [self.bottomBar setHidden:YES];
    [self vs_showRightButton:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)applyButton {
    if (!_applyButton) {
        _applyButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 130, 0, 130, 49)];
        [_applyButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_applyButton setTitleColor:ColorWithHex(0xffffff, 1.0) forState:UIControlStateNormal];
    }
    return _applyButton;
}

- (UIView *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, GetHeight(self.view)-49 -64, __SCREEN_WIDTH__, 49)];
        [_bottomBar setBackgroundColor:[UIColor whiteColor]];
        [_bottomBar addSubview:self.applyButton];
        
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 9, 30, 30)];
        [phoneImageView setImage:__IMAGENAMED__(@"icon-Telephone-nv")];
        [_bottomBar addSubview:phoneImageView];
        
        UIButton *phoneLabel = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 190, 49)];
        [phoneLabel setTitle:@"4008320087" forState:UIControlStateNormal];
        [phoneLabel setTitleColor:ColorWithHex(0x353535, 1.0) forState:UIControlStateNormal];
        [phoneLabel.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [phoneLabel addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBar addSubview:phoneLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, 1)];
        [lineView setBackgroundColor:ColorWithHex(0xeeeeee, 1.0)];
        [_bottomBar addSubview:lineView];
    }
    return _bottomBar;
}

- (void)phoneAction {
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4008320087"];
    // NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)fetchApplyPolicyInterface {
    dispatch_group_enter(requestGroup);
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:partyId,@"partyId",
                             self.p_model.policyId,@"policyId",
                             [BidderManager shareInstance].authedEnterPrise.bidder.enterpriseName,@"enterpriseName",
                             self.selectedAreaId,@"areaName",
                             [BidderManager shareInstance].authedEnterPrise.bidder.enterpriseLegalPerson,@"legalPerson",
                             [BidderManager shareInstance].authedEnterPrise.bidder.contactName,@"contactPerson",
                             [BidderManager shareInstance].authedEnterPrise.bidder.contactNumber,@"contactNumber",
                             nil];
    
    NSString *jsonString = [VSPageRoute dictionaryToJson:dic];
    dic = @{@"content":jsonString};
    
    [BCNetWorkTool executePostNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.policy/apply-policy/version/1.2.2" withSuccess:^(id callBackData) {
        [self.view showTipsView:@"您的申请已提交，请耐心等待结果"];
        self.p_model.policyStatus = @"APPLIED";
        [self vs_hideLoadingWithCompleteBlock:^{
            [self refresh];
            [self loadData];
        }];
        dispatch_group_leave(requestGroup);
    } orFail:^(id callBackData) {
        [self.view showTipsView:[callBackData domain]];
        [self vs_hideLoadingWithCompleteBlock:nil];
        dispatch_group_leave(requestGroup);
    }];
}

- (void)checkEnterpriseStatus {
    [self vs_showLoading];
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *dic = @{
                          @"partyId" : partyId
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-authed-enterprise/version/1.2.0" withSuccess:^(id callBackData) {
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [BidderManager shareInstance].authedEnterPrise = [AuthedEnterprise mj_objectWithKeyValues:callBackData];
        
        
        NSString *status = [BidderManager shareInstance].authedEnterPrise.authStatus;
        
        if ([status isEqualToString:@"UNAPPLY"]) {
            AuthEnterpriseViewController *vc = [AuthEnterpriseViewController new];
            [vc setDataSource:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder];
            [self.navigationController pushViewController:vc animated:YES];
        }else if([status isEqualToString:@"UNRESOLVED"]){
            
            [self.view showTipsView:@"您的企业信息还在认证中，请耐心等待"];
            
        }else if([status isEqualToString:@"PASS"]){
            
            [self fetchApplyPolicyInterface];
            
        }else if([status isEqualToString:@"REJECT"]){
            AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES ];
        }
    } orFail:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

- (void)applyAction {
    [self checkEnterpriseStatus];
}

- (void)loadData {
    //判断是否收藏
    if ([self.p_model.isCollected isEqualToString:@"Y"]) {
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_h") forState:UIControlStateNormal];
    } else if ([self.p_model.isCollected isEqualToString:@"N"]) {
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_n") forState:UIControlStateNormal];
    }
    
    if ([self.p_model.policyStatus isEqualToString:@"NOT_START"]) {
        [self.applyButton setTitle:@"未开始" forState:UIControlStateNormal];
        [self.applyButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
        [self.applyButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
        [self.applyButton setEnabled:NO];
    } else if ([self.p_model.policyStatus isEqualToString:@"APPLIED"]) {
        [self.applyButton setTitle:@"已申请" forState:UIControlStateNormal];
        [self.applyButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
        [self.applyButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
        [self.applyButton setEnabled:NO];
    } else if ([self.p_model.policyStatus isEqualToString:@"COMPLETED"]) {
        if ([self.p_model.isAllowApply isEqualToString:@"N"]) {
            [self.applyButton setTitle:@"已申请" forState:UIControlStateNormal];
            [self.applyButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
            [self.applyButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
            [self.applyButton setEnabled:NO];
        } else if ([self.p_model.isAllowApply isEqualToString:@"Y"]) {
            [self.applyButton setTitle:@"已结束" forState:UIControlStateNormal];
            [self.applyButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
            [self.applyButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
            [self.applyButton setEnabled:NO];
        }
        
    } else if ([self.p_model.policyStatus isEqualToString:@"STARTED"]) {
        if ([self.p_model.publicityStatus isEqualToString:@"Y"]) {
//            if ([self.p_model.isAllowApply isEqualToString:@"N"]) {
//                [self.applyButton setTitle:@"已申请" forState:UIControlStateNormal];
//                [self.applyButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
//                [self.applyButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
//                [self.applyButton setEnabled:NO];
//            } else if ([self.p_model.isAllowApply isEqualToString:@"Y"]) {
                [self.applyButton setTitle:@"已结束" forState:UIControlStateNormal];
                [self.applyButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
                [self.applyButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
                [self.applyButton setEnabled:NO];
         //   }
        } else if ([self.p_model.publicityStatus isEqualToString:@"N"]) {
            if ([self.p_model.isAllowApply isEqualToString:@"N"]) {
                [self.applyButton setTitle:@"已申请" forState:UIControlStateNormal];
                [self.applyButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
                [self.applyButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
                [self.applyButton setEnabled:NO];
            } else if ([self.p_model.isAllowApply isEqualToString:@"Y"]) {
                [self.applyButton setTitle:@"立即申请" forState:UIControlStateNormal];
                [self.applyButton setTitleColor:ColorWithHex(0xffffff, 1.0) forState:UIControlStateNormal];
                [self.applyButton setBackgroundColor:ColorWithHex(0xffb94a, 1.0)];
                [self.applyButton addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
                [self.applyButton setEnabled:YES];
            }
        }
    }
    
    //    //test
    //    [self.enrollButton addTarget:self action:@selector(completeEnrollInfo) forControlEvents:UIControlEventTouchUpInside];
    //    [self.enrollButton setEnabled:YES];
}

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 65, 7, 30, 30)];
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_n") forState:UIControlStateNormal];
        [_collectButton addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectButton;
}

- (void)startRequest {
    
    dispatch_group_enter(requestGroup);
    
}
- (void)endRequest {
    
    dispatch_group_leave(requestGroup);
    
}

- (void)collectionAction {
    //收藏动作
    [self startRequest];
    NSString *action;
    if ([self.p_model.isCollected isEqualToString:@"Y"]) {
        action = @"0";
    } else if ([self.p_model.isCollected isEqualToString:@"N"]) {
        action = @"1";
    }
    
    [manager onCollectPolicy:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"" policyId:self.p_model.policyId action:action success:^(NSDictionary *responseObj) {
        if ([self.p_model.isCollected isEqualToString:@"Y"]) {
            self.p_model.isCollected = @"N";
        }else{
            self.p_model.isCollected = @"Y";
        }
        
        if ([self.p_model.isCollected isEqualToString:@"Y"]) {
            [self.collectButton setImage:[UIImage imageNamed:@"nav_btn_Collection_h"] forState:UIControlStateNormal];
        }else{
            [self.collectButton setImage:[UIImage imageNamed:@"nav_btn_Collection_n"] forState:UIControlStateNormal];
        }
        NSString *tittle = [action isEqualToString:@"1"] ? @"收藏成功！":@"取消收藏成功！";
        [self.view showTipsView:tittle];
        [self endRequest];
    } failure:^(NSError *error) {
        [self endRequest];
        [self.view showTipsView:[error domain]];
    }];
}

@end
