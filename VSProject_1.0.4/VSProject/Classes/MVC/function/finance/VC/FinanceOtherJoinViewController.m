//
//  FinanceOtherJoinViewController.m
//  VSProject
//
//  Created by pangchao on 17/1/5.
//  Copyright © 2017年 user. All rights reserved.
//

#import "FinanceOtherJoinViewController.h"
#import "PlaceholderTextView.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "BCNetWorkTool.h"

@interface FinanceOtherJoinViewController () <UITextFieldDelegate, UITextViewDelegate>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIView *appointmentView; // 存放所有控件
@property (nonatomic, strong) UIScrollView *appointmentScrollView;

@property (nonatomic, strong) UILabel *companyNameLabel; // 企业名称
@property (nonatomic, strong) UITextField *companyNameEdit; // 企业名称输入

@property (nonatomic, strong) UILabel *scaleLabel; // 企业规模
@property (nonatomic, strong) UITextField *scaleEdit; // 企业规模输入

@property (nonatomic, strong) UILabel *revenueLabel; // 企业营收
@property (nonatomic, strong) UITextField *revenueEdit; // 企业营收输入

@property (nonatomic, strong) UILabel *tradeLabel; // 行业类型
@property (nonatomic, strong) UITextField *tradeEdit; // 行业类型输入

@property (nonatomic, strong) UILabel *contactPersonLabel; // 联系人
@property (nonatomic, strong) UITextField *contactPersonEdit; // 联系人输入

@property (nonatomic, strong) UILabel *telphoneLabel;  // 联系电话
@property (nonatomic, strong) UITextField *telphoneEdit; // 联系电话输出

@property (nonatomic, strong) UILabel *needLabel; // 项目简介
@property (nonatomic, strong) PlaceholderTextView *needTextView; // 项目简介
@property (nonatomic, strong) UILabel *limitTipsLable;

/*
@property (nonatomic, strong) UIView *tipsView;
@property (nonatomic, strong) UIView *flagView;
@property (nonatomic, strong) UILabel *mailLabel;
 */

@property (nonatomic, strong) UIButton *commitButton; // 提交按钮

@end

@implementation FinanceOtherJoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"申请信息填写"];
    
    requestGroup = dispatch_group_create();
    
    [self.view addSubview:self.appointmentScrollView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIView *)appointmentView {
    
    if (!_appointmentView) {
        _appointmentView = [[UIView alloc] init];
        _appointmentView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f);
        _appointmentView.backgroundColor = [UIColor whiteColor];
        
        [_appointmentView addSubview:self.companyNameLabel];
        [_appointmentView addSubview:self.companyNameEdit];
        [_appointmentView addSubview:self.scaleLabel];
        [_appointmentView addSubview:self.scaleEdit];
        [_appointmentView addSubview:self.revenueLabel];
        [_appointmentView addSubview:self.revenueEdit];
        [_appointmentView addSubview:self.tradeLabel];
        [_appointmentView addSubview:self.tradeEdit];
        [_appointmentView addSubview:self.contactPersonLabel];
        [_appointmentView addSubview:self.contactPersonEdit];
        [_appointmentView addSubview:self.telphoneLabel];
        [_appointmentView addSubview:self.telphoneEdit];
        [_appointmentView addSubview:self.needLabel];
        [_appointmentView addSubview:self.needTextView];
        [_appointmentView addSubview:self.commitButton];
        
        _appointmentView.frame = CGRectMake(0, 0, MainWidth, self.commitButton.frame.origin.y + self.commitButton.frame.size.height + 40.0f);
    }
    return _appointmentView;
}

- (UIScrollView *)appointmentScrollView {
    
    if (!_appointmentScrollView) {
        _appointmentScrollView = [[UIScrollView alloc] init];
        _appointmentScrollView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f);
        _appointmentScrollView.backgroundColor = [UIColor whiteColor];
        _appointmentScrollView.showsVerticalScrollIndicator = YES;
        _appointmentScrollView.showsHorizontalScrollIndicator = NO;
        
        [_appointmentScrollView addSubview:self.appointmentView];
        _appointmentScrollView.contentSize = CGSizeMake(self.appointmentView.frame.size.width, self.appointmentView.frame.size.height);
    }
    return _appointmentScrollView;
}

- (UILabel *)companyNameLabel {
    
    if (!_companyNameLabel) {
        _companyNameLabel = [[UILabel alloc] init];
        _companyNameLabel.frame = CGRectMake(20.0f, 20.0f, MainWidth - 20.0f*2, 13.0f);
        _companyNameLabel.font = [UIFont systemFontOfSize:13.0f];
        _companyNameLabel.textColor = _COLOR_HEX(0x333333);
        _companyNameLabel.textAlignment = NSTextAlignmentLeft;
        _companyNameLabel.text = @"企业名称";
    }
    return _companyNameLabel;
}

- (UITextField *)companyNameEdit {
    
    if (!_companyNameEdit) {
        _companyNameEdit = [[UITextField alloc] init];
        _companyNameEdit.frame = CGRectMake(20.0f, self.companyNameLabel.frame.origin.y + self.companyNameLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _companyNameEdit.attributedPlaceholder = placeHolder;
        _companyNameEdit.textAlignment = NSTextAlignmentCenter;
        _companyNameEdit.backgroundColor = [UIColor whiteColor];
        _companyNameEdit.layer.masksToBounds = YES;
        _companyNameEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _companyNameEdit.layer.borderWidth = 0.5f;
        _companyNameEdit.layer.cornerRadius = 10.0f;
        [_companyNameEdit setTintColor:_COLOR_HEX(0x999999)];
        _companyNameEdit.delegate = self;
    }
    return _companyNameEdit;
}

- (UILabel *)scaleLabel {
    
    if (!_scaleLabel) {
        _scaleLabel = [[UILabel alloc] init];
        _scaleLabel.frame = CGRectMake(20.0f, self.companyNameEdit.frame.origin.y + self.companyNameEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _scaleLabel.font = [UIFont systemFontOfSize:13.0f];
        _scaleLabel.textColor = _COLOR_HEX(0x333333);
        _scaleLabel.textAlignment = NSTextAlignmentLeft;
        _scaleLabel.text = @"企业规模";
    }
    return _scaleLabel;
}

- (UITextField *)scaleEdit {
    
    if (!_scaleEdit) {
        _scaleEdit = [[UITextField alloc] init];
        _scaleEdit.frame = CGRectMake(20.0f, self.scaleLabel.frame.origin.y + self.scaleLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _scaleEdit.attributedPlaceholder = placeHolder;
        _scaleEdit.textAlignment = NSTextAlignmentCenter;
        _scaleEdit.backgroundColor = [UIColor whiteColor];
        _scaleEdit.layer.masksToBounds = YES;
        _scaleEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _scaleEdit.layer.borderWidth = 0.5f;
        _scaleEdit.layer.cornerRadius = 10.0f;
        [_scaleEdit setTintColor:_COLOR_HEX(0x999999)];
        _scaleEdit.delegate = self;
    }
    return _scaleEdit;
}

- (UILabel *)revenueLabel {
    
    if (!_revenueLabel) {
        _revenueLabel = [[UILabel alloc] init];
        _revenueLabel.frame = CGRectMake(20.0f, self.scaleEdit.frame.origin.y + self.scaleEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _revenueLabel.font = [UIFont systemFontOfSize:13.0f];
        _revenueLabel.textColor = _COLOR_HEX(0x333333);
        _revenueLabel.textAlignment = NSTextAlignmentLeft;
        _revenueLabel.text = @"企业营收";
    }
    return _revenueLabel;
}

- (UITextField *)revenueEdit {
    
    if (!_revenueEdit) {
        _revenueEdit = [[UITextField alloc] init];
        _revenueEdit.frame = CGRectMake(20.0f, self.revenueLabel.frame.origin.y + self.revenueLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _revenueEdit.attributedPlaceholder = placeHolder;
        _revenueEdit.textAlignment = NSTextAlignmentCenter;
        _revenueEdit.backgroundColor = [UIColor whiteColor];
        _revenueEdit.layer.masksToBounds = YES;
        _revenueEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _revenueEdit.layer.borderWidth = 0.5f;
        _revenueEdit.layer.cornerRadius = 10.0f;
        [_revenueEdit setTintColor:_COLOR_HEX(0x999999)];
        _revenueEdit.delegate = self;
    }
    return _revenueEdit;
}

- (UILabel *)tradeLabel {
    
    if (!_tradeLabel) {
        _tradeLabel = [[UILabel alloc] init];
        _tradeLabel.frame = CGRectMake(20.0f, self.revenueEdit.frame.origin.y + self.revenueEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _tradeLabel.font = [UIFont systemFontOfSize:13.0f];
        _tradeLabel.textColor = _COLOR_HEX(0x333333);
        _tradeLabel.textAlignment = NSTextAlignmentLeft;
        _tradeLabel.text = @"行业类型";
    }
    return _tradeLabel;
}

- (UITextField *)tradeEdit {
    
    if (!_tradeEdit) {
        _tradeEdit = [[UITextField alloc] init];
        _tradeEdit.frame = CGRectMake(20.0f, self.tradeLabel.frame.origin.y + self.tradeLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _tradeEdit.attributedPlaceholder = placeHolder;
        _tradeEdit.textAlignment = NSTextAlignmentCenter;
        _tradeEdit.backgroundColor = [UIColor whiteColor];
        _tradeEdit.layer.masksToBounds = YES;
        _tradeEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _tradeEdit.layer.borderWidth = 0.5f;
        _tradeEdit.layer.cornerRadius = 10.0f;
        [_tradeEdit setTintColor:_COLOR_HEX(0x999999)];
        _tradeEdit.delegate = self;
    }
    return _tradeEdit;
}

- (UILabel *)contactPersonLabel {
    
    if (!_contactPersonLabel) {
        _contactPersonLabel = [[UILabel alloc] init];
        _contactPersonLabel.frame = CGRectMake(20.0f, self.tradeEdit.frame.origin.y + self.tradeEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
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
        _contactPersonEdit.layer.cornerRadius = 10.0f;
        [_contactPersonEdit setTintColor:_COLOR_HEX(0x999999)];
        _contactPersonEdit.delegate = self;
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
        _telphoneLabel.text = @"联系电话";
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
        _telphoneEdit.backgroundColor = [UIColor whiteColor];
        _telphoneEdit.layer.masksToBounds = YES;
        _telphoneEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _telphoneEdit.layer.borderWidth = 0.5f;
        _telphoneEdit.layer.cornerRadius = 10.0f;
        [_telphoneEdit setTintColor:_COLOR_HEX(0x999999)];
        _telphoneEdit.delegate = self;
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
        _needLabel.text = @"项目简介";
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
        _needTextView.layer.masksToBounds = YES;
        _needTextView.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _needTextView.layer.borderWidth = 0.5f;
        _needTextView.layer.cornerRadius = 10.0f;
        [_needTextView addSubview:self.limitTipsLable];
        _needTextView.delegate = self;
    }
    return _needTextView;
}

- (UILabel *)limitTipsLable {
    if (!_limitTipsLable) {
        _limitTipsLable = [[UILabel alloc] init];
        _limitTipsLable.frame = CGRectMake(MainWidth - 20.0f*2.0f - 14.0f*2.0f - 100.0f, 200.0f - 15.0f - 19.0f, 100.0f, 19.0f);
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
        _commitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_commitButton setTitle:@"提交申请" forState:UIControlStateNormal];
        _commitButton.layer.cornerRadius = 10.0f;
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton setBackgroundColor:_COLOR_HEX(0x00c78c)];
        
        [_commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (void)commitAction:(UIButton *)button {
    if ([self.contactPersonEdit.text isEqualToString:@""] || [self.telphoneEdit.text isEqualToString:@""] || [self.companyNameEdit.text isEqualToString:@""] || [self.scaleEdit.text isEqualToString:@""] || [self.revenueEdit.text isEqualToString:@""] || [self.tradeEdit.text isEqualToString:@""]) {
        PXAlertView *alertView = [PXAlertView showAlertWithTitle:@"提示" message:@"亲~你还有信息未填写哦~" cancelTitle:@"确定" otherTitle:nil completion:^(BOOL cancelled, NSInteger buttonIndex) {
        }];
        
        [alertView setBackgroundColor:[UIColor whiteColor]];
        [alertView setTitleColor:[UIColor grayColor]];
        [alertView setMessageColor:[UIColor grayColor]];
        [alertView setCancelButtonTextColor:[UIColor grayColor]];
        [alertView setOtherButtonTextColor:[UIColor grayColor]];
    }
    else {
        // 提交
        [self commitJoin];
    }
}

- (void)commitJoin {
    
    dispatch_group_enter(requestGroup);
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *contact = self.contactPersonEdit.text; // 联系人
    NSString *enterpriseName = self.companyNameEdit.text;
    NSString *enterpriseScale = self.scaleEdit.text; // 企业规模
    NSString *enterpriseRevenue = self.revenueEdit.text; // 企业营收
    NSString *contactNumber = self.telphoneEdit.text;  // 联系方式
    NSString *formComment = self.needTextView.text;    // 项目简介
    NSString *businessType = self.tradeEdit.text; // 企业类型
    NSDictionary *dic = @{
                          @"partyId" : partyId,
                          @"enterpriseName" : enterpriseName,
                          @"cooperationType" : self.cooperationType,
                          @"enterpriseScale" : enterpriseScale,
                          @"enterpriseRevenue" : enterpriseRevenue,
                          @"contact" : contact,
                          @"contactNumber" : contactNumber,
                          @"formComment" : formComment,
                          @"businessType" : businessType,
                          };
    
    NSString *jsonString = [VSPageRoute dictionaryToJson:dic];
    dic = @{@"content":jsonString};
    
    __weak typeof(self)weakself = self;
    [self vs_showLoading];
    [BCNetWorkTool executePostNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.home/cooperation-apply/version/1.5.1" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        [weakself.view showTipsView:@"提交成功"];
        [weakself vs_hideLoadingWithCompleteBlock:^() {
            [weakself.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:1.5];
        }];
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        [weakself.view showTipsView:[callBackData domain]];
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        dispatch_group_leave(requestGroup);
    }];
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
    if (self.companyNameEdit.text.length > 0 &&
        self.scaleEdit.text.length > 0 &&
        self.revenueEdit.text.length > 0 &&
        self.contactPersonEdit.text.length > 0 &&
        self.telphoneEdit.text.length > 0) {
        
        if (self.telphoneEdit.text.length == 11 && [self.telphoneEdit.text hasPrefix:@"1"]) {
            [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.commitButton setEnabled:YES];
        }
    }
}

@end
