//
//  PolicyProxyViewController.m
//  VSProject
//
//  Created by apple on 1/5/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "PolicyProxyViewController.h"
#import "BCNetWorkTool.h"
#import "PlaceholderTextView.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"

@interface PolicyProxyViewController () <UITextFieldDelegate,UITextViewDelegate>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIView *appointmentView; // 存放所有控件

@property (nonatomic, strong) UILabel *enterpriseNameLabel; // 企业名称
@property (nonatomic, strong) UITextField *enterpriseNameEdit; // 企业名称输入

@property (nonatomic, strong) UILabel *shenBaoNameLabel; // 申报名称
@property (nonatomic, strong) UITextField *shenBaoNameEdit; // 申报名称输入

@property (nonatomic, strong) UILabel *contactPersonLabel; // 联系人
@property (nonatomic, strong) UITextField *contactPersonEdit; // 联系人输入

@property (nonatomic, strong) UILabel *telphoneLabel;  // 联系电话
@property (nonatomic, strong) UITextField *telphoneEdit; // 联系电话输出

@property (nonatomic, strong) UILabel *needLabel; // 需求
@property (nonatomic, strong) PlaceholderTextView *needTextView; // 需求填写
@property (nonatomic, strong) UILabel *limitTipsLable;

@property (nonatomic, strong) UIButton *commitButton; // 提交按钮

@end

@implementation PolicyProxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"委托申报信息填写"];
    
    self.view.backgroundColor = _COLOR_HEX(0xffffff);
    
    requestGroup = dispatch_group_create();
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - 64.0f)];
    [scrollView setContentSize:self.appointmentView.frame.size];
    [scrollView addSubview:self.appointmentView];
    
    [self.view addSubview:scrollView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [self performSelector:@selector(verifyData) withObject:nil afterDelay:0.1];
    if (range.length + range.location > 2000 && ![text isEqualToString:@""]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)verifyData {
    if (self.contactPersonEdit.text.length > 0 &&
        self.telphoneEdit.text.length > 0 &&
        self.needTextView.text.length > 0 ) {
        
        if (self.telphoneEdit.text.length == 11 && [self.telphoneEdit.text hasPrefix:@"1"]) {
            [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.commitButton setEnabled:YES];
        } else {
            [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.commitButton setEnabled:YES];
        }
    } else {
        [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.commitButton setEnabled:YES];
    }
}


- (UIView *)appointmentView {
    
    if (!_appointmentView) {
        _appointmentView = [[UIView alloc] init];
        _appointmentView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f);
        
        [_appointmentView addSubview:self.enterpriseNameLabel];
        [_appointmentView addSubview:self.enterpriseNameEdit];
        [_appointmentView addSubview:self.shenBaoNameLabel];
        [_appointmentView addSubview:self.shenBaoNameEdit];
        [_appointmentView addSubview:self.contactPersonLabel];
        [_appointmentView addSubview:self.contactPersonEdit];
        [_appointmentView addSubview:self.telphoneLabel];
        [_appointmentView addSubview:self.telphoneEdit];
        [_appointmentView addSubview:self.needLabel];
        [_appointmentView addSubview:self.needTextView];
        [_appointmentView addSubview:self.commitButton];
        
        [_appointmentView setFrame:CGRectMake(0, 0, MainWidth, self.commitButton.frame.origin.y + self.commitButton.frame.size.height + 40)];
    }
    return _appointmentView;
}

- (UILabel *)enterpriseNameLabel {
    
    if (!_enterpriseNameLabel) {
        _enterpriseNameLabel = [[UILabel alloc] init];
        _enterpriseNameLabel.frame = CGRectMake(20.0f, 20.0f, MainWidth - 20.0f*2, 13.0f);
        _enterpriseNameLabel.font = [UIFont systemFontOfSize:13.0f];
        _enterpriseNameLabel.textColor = _COLOR_HEX(0x333333);
        _enterpriseNameLabel.textAlignment = NSTextAlignmentLeft;
        _enterpriseNameLabel.text = @"企业名称";
    }
    return _enterpriseNameLabel;
}

- (UITextField *)enterpriseNameEdit {
    
    if (!_enterpriseNameEdit) {
        _enterpriseNameEdit = [[UITextField alloc] init];
        _enterpriseNameEdit.frame = CGRectMake(20.0f, self.enterpriseNameLabel.frame.origin.y + self.enterpriseNameLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _enterpriseNameEdit.attributedPlaceholder = placeHolder;
        _enterpriseNameEdit.textAlignment = NSTextAlignmentCenter;
        _enterpriseNameEdit.backgroundColor = [UIColor whiteColor];
        _enterpriseNameEdit.layer.masksToBounds = YES;
        _enterpriseNameEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _enterpriseNameEdit.layer.borderWidth = 0.5f;
        _enterpriseNameEdit.layer.cornerRadius = 6.0f;
        [_enterpriseNameEdit setTintColor:_COLOR_HEX(0x999999)];
    }
    return _enterpriseNameEdit;
}

- (UILabel *)shenBaoNameLabel {
    
    if (!_shenBaoNameLabel) {
        _shenBaoNameLabel = [[UILabel alloc] init];
        _shenBaoNameLabel.frame = CGRectMake(20.0f, self.enterpriseNameEdit.frame.origin.y + self.enterpriseNameEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _shenBaoNameLabel.font = [UIFont systemFontOfSize:13.0f];
        _shenBaoNameLabel.textColor = _COLOR_HEX(0x333333);
        _shenBaoNameLabel.textAlignment = NSTextAlignmentLeft;
        _shenBaoNameLabel.text = @"申报名称";
    }
    return _shenBaoNameLabel;
}

- (UITextField *)shenBaoNameEdit {
    
    if (!_shenBaoNameEdit) {
        _shenBaoNameEdit = [[UITextField alloc] init];
        _shenBaoNameEdit.frame = CGRectMake(20.0f, self.shenBaoNameLabel.frame.origin.y + self.shenBaoNameLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _shenBaoNameEdit.attributedPlaceholder = placeHolder;
        _shenBaoNameEdit.textAlignment = NSTextAlignmentCenter;
        _shenBaoNameEdit.backgroundColor = [UIColor whiteColor];
        _shenBaoNameEdit.layer.masksToBounds = YES;
        _shenBaoNameEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _shenBaoNameEdit.layer.borderWidth = 0.5f;
        _shenBaoNameEdit.layer.cornerRadius = 6.0f;
        [_shenBaoNameEdit setTintColor:_COLOR_HEX(0x999999)];
    }
    return _shenBaoNameEdit;
}

- (UILabel *)contactPersonLabel {
    
    if (!_contactPersonLabel) {
        _contactPersonLabel = [[UILabel alloc] init];
        _contactPersonLabel.frame = CGRectMake(20.0f, self.shenBaoNameEdit.frame.origin.y + self.shenBaoNameEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _contactPersonLabel.font = [UIFont systemFontOfSize:13.0f];
        _contactPersonLabel.textColor = _COLOR_HEX(0x333333);
        _contactPersonLabel.textAlignment = NSTextAlignmentLeft;
        _contactPersonLabel.text = @"联系人";
    }
    return _contactPersonLabel;
}

- (UITextField *)contactPersonEdit {
    
    if (!_contactPersonEdit) {
        _contactPersonEdit = [[UITextField alloc] init];
        _contactPersonEdit.frame = CGRectMake(20.0f, self.contactPersonLabel.frame.origin.y + self.contactPersonLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _contactPersonEdit.attributedPlaceholder = placeHolder;
        _contactPersonEdit.textAlignment = NSTextAlignmentCenter;
        _contactPersonEdit.backgroundColor = [UIColor whiteColor];
        _contactPersonEdit.layer.masksToBounds = YES;
        _contactPersonEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _contactPersonEdit.layer.borderWidth = 0.5f;
        _contactPersonEdit.layer.cornerRadius = 6.0f;
        [_contactPersonEdit setTintColor:_COLOR_HEX(0x999999)];
    }
    return _contactPersonEdit;
}

- (UILabel *)telphoneLabel {
    
    if (!_telphoneLabel) {
        _telphoneLabel = [[UILabel alloc] init];
        _telphoneLabel.frame = CGRectMake(20.0f, self.contactPersonEdit.frame.origin.y + self.contactPersonEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _telphoneLabel.font = [UIFont systemFontOfSize:13.0f];
        _telphoneLabel.textColor = _COLOR_HEX(0x333333);
        _telphoneLabel.textAlignment = NSTextAlignmentLeft;
        _telphoneLabel.text = @"联系方式";
    }
    return _telphoneLabel;
}

- (UITextField *)telphoneEdit {
    
    if (!_telphoneEdit) {
        _telphoneEdit = [[UITextField alloc] init];
        _telphoneEdit.frame = CGRectMake(20.0f, self.telphoneLabel.frame.origin.y + self.telphoneLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _telphoneEdit.attributedPlaceholder = placeHolder;
        _telphoneEdit.textAlignment = NSTextAlignmentCenter;
        _telphoneEdit.keyboardType = UIKeyboardTypeNumberPad;
        _telphoneEdit.backgroundColor = [UIColor whiteColor];
        _telphoneEdit.delegate = self;
        _telphoneEdit.layer.masksToBounds = YES;
        _telphoneEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _telphoneEdit.layer.borderWidth = 0.5f;
        _telphoneEdit.layer.cornerRadius = 6.0f;
        [_telphoneEdit setTintColor:_COLOR_HEX(0x999999)];
    }
    return _telphoneEdit;
}

- (UILabel *)needLabel {
    
    if(!_needLabel) {
        _needLabel = [[UILabel alloc] init];
        _needLabel.frame = CGRectMake(20.0f, self.telphoneEdit.frame.origin.y + self.telphoneEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _needLabel.font = [UIFont systemFontOfSize:13.0f];
        _needLabel.textColor = _COLOR_HEX(0x333333);
        _needLabel.textAlignment = NSTextAlignmentLeft;
        _needLabel.text = @"企业留言";
    }
    return _needLabel;
}

- (PlaceholderTextView *)needTextView {
    
    if (!_needTextView) {
        _needTextView = [[PlaceholderTextView alloc] init];
        _needTextView.frame = CGRectMake(20.0f, self.needLabel.frame.origin.y + self.needLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 200.0f);
        _needTextView.textAlignment = NSTextAlignmentCenter;
        _needTextView.backgroundColor = [UIColor whiteColor];
        _needTextView.scrollEnabled = NO;
        _needTextView.editable = YES;
        _needTextView.font = [UIFont systemFontOfSize:13.0f];
        _needTextView.textColor = _COLOR_HEX(0x444444);
        _needTextView.textAlignment = NSTextAlignmentLeft;
        _needTextView.dataDetectorTypes = UIDataDetectorTypeAll;
        _needTextView.layoutManager.allowsNonContiguousLayout = NO;
        _needTextView.placeholderColor = _COLOR_HEX(0xcccccc);
        _needTextView.backgroundColor = [UIColor whiteColor];
        _needTextView.delegate = self;
        _needTextView.layer.masksToBounds = YES;
        _needTextView.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _needTextView.layer.borderWidth = 0.5f;
        _needTextView.layer.cornerRadius = 6.0f;
        [_needTextView addSubview:self.limitTipsLable];
    }
    return _needTextView;
}

- (UILabel *)limitTipsLable {
    if (!_limitTipsLable) {
        _limitTipsLable = [[UILabel alloc] init];
        _limitTipsLable.frame = CGRectMake(MainWidth - 20.0f*2.0f - 14.0f*2.0f - 100.0f, self.needTextView.frame.size.height - 25, 100.0f, 19.0f);
        _limitTipsLable.font = [UIFont systemFontOfSize:13.0f];
        _limitTipsLable.textColor = _COLOR_HEX(0xcccccc);
        _limitTipsLable.textAlignment = NSTextAlignmentRight;
        _limitTipsLable.text = @"限2000字";
    }
    return _limitTipsLable;
}

- (UIButton *)commitButton {
    
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] init];
        _commitButton.frame = CGRectMake(20.0f, self.needTextView.frame.origin.y + self.needTextView.frame.size.height + 30.0f, MainWidth - 20.0f*2, 44.0f);
        [_commitButton setBackgroundColor:ColorWithHex(0x00C88D, 1.0)];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton setEnabled:YES];
        _commitButton.layer.masksToBounds = YES;
        _commitButton.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _commitButton.layer.borderWidth = 0.5f;
        _commitButton.layer.cornerRadius = 6.0f;
        [_commitButton setTitle:@"我要委托" forState:UIControlStateNormal];
        
        [_commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (void)commitAction:(UIButton *)button {
    
    if ([self.contactPersonEdit.text isEqualToString:@""] || [self.telphoneEdit.text isEqualToString:@""] || [self.enterpriseNameEdit.text isEqualToString:@""] || [self.shenBaoNameEdit.text isEqualToString:@""]) {
        [self.view showTipsView:@"亲~你还有信息未填写哦~"];
    }
    else {
        // 提交
        [self productSubscribe];
    }
}

- (void)productSubscribe {
    
    dispatch_group_enter(requestGroup);
    
    //android入参
//{"customerJob":"",
//    "contactNumber":"15886699888",
//    "enterpriseScale":"",
//    "enterpriseIdentity":"",
//    "enterpriseName":"",
//    "corporateFinance":"",
//    "businessType":"",
//    "contact":"刚刚好你",
//    "cooperationType":"3",
//    "partyId":"1305",
//    "visit-party-id":"1305",
//    "enterpriseRevenue":"",
//    "cooperationMode":"",
//    "biddingAgent":"",
//    "cooperationIntention":"",
//    "formComment":"一会的话不得不把"}
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSDictionary *dic = @{
                          @"partyId" : partyId,
                          @"cooperationType" : @"3",
                          @"contact" : self.contactPersonEdit.text,
                          @"contactNumber" : self.telphoneEdit.text,
                          @"enterpriseName":self.enterpriseNameEdit.text,
                          @"declarationName":self.shenBaoNameEdit.text,
                          @"remark" : self.needTextView.text,
                          };
    
    NSString *jsonString = [VSPageRoute dictionaryToJson:dic];
    dic = @{@"content":jsonString};
    
    __weak typeof(self)weakself = self;
    [self vs_showLoading];
    [BCNetWorkTool executePostNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.home/cooperation-apply/version/1.5.1" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        [weakself.view showTipsView:@"申请已经提交成功,\n请耐心等待工作人员审核"];
        [weakself vs_hideLoadingWithCompleteBlock:^{
            [weakself.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:1.5];
        }];
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        [weakself.view showTipsView:[callBackData domain]];
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        dispatch_group_leave(requestGroup);
    }];
}

@end
