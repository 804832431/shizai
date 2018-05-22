//
//  AppointmentViewController.m
//  VSProject
//
//  Created by pangchao on 16/12/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import "AppointmentViewController.h"
#import "BCNetWorkTool.h"
#import "BidderManager.h"
#import "AuthEnterpriseTableViewCell.h"
#import "AuthStatusUnReslovedViewController.h"
#import "MyAuthHistoryViewController.h"
#import "PlaceholderTextView.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "BCNetWorkTool.h"

@interface AppointmentViewController () <UITextFieldDelegate,UITextViewDelegate>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIView *appointmentView; // 存放所有控件

@property (nonatomic, strong) UILabel *contactPersonLabel; // 联系人
@property (nonatomic, strong) UITextField *contactPersonEdit; // 联系人输入

@property (nonatomic, strong) UILabel *telphoneLabel;  // 联系电话
@property (nonatomic, strong) UITextField *telphoneEdit; // 联系电话输出

@property (nonatomic, strong) UILabel *enterpriseNameLabel;  // 企业名称
@property (nonatomic, strong) UITextField *enterpriseNameEdit; // 企业名称输出

@property (nonatomic, strong) UILabel *staffNumberLabel;  // 企业人数
@property (nonatomic, strong) UITextField *staffNumberEdit; // 企业人数输出

@property (nonatomic, strong) UILabel *needLabel; // 需求
@property (nonatomic, strong) PlaceholderTextView *needTextView; // 需求填写
@property (nonatomic, strong) UILabel *limitTipsLable;

@property (nonatomic, strong) UIView *tipsView; //提示view

@property (nonatomic, strong) UIButton *commitButton; // 提交按钮

@end

@implementation AppointmentViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self vs_setTitleText:@"预约信息填写"];
    
    self.view.backgroundColor = _COLOR_HEX(0xffffff);
    
    requestGroup = dispatch_group_create();
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - 64.0f)];
    [scrollView setContentSize:self.appointmentView.frame.size];
    [scrollView addSubview:self.appointmentView];
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        }
    }
}

- (UIView *)appointmentView {
    
    if (!_appointmentView) {
        _appointmentView = [[UIView alloc] init];
        _appointmentView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 44.0f);
        
        [_appointmentView addSubview:self.contactPersonLabel];
        [_appointmentView addSubview:self.contactPersonEdit];
        [_appointmentView addSubview:self.telphoneLabel];
        [_appointmentView addSubview:self.telphoneEdit];
        [_appointmentView addSubview:self.enterpriseNameLabel];
        [_appointmentView addSubview:self.enterpriseNameEdit];
        [_appointmentView addSubview:self.staffNumberLabel];
        [_appointmentView addSubview:self.staffNumberEdit];
        [_appointmentView addSubview:self.needLabel];
        [_appointmentView addSubview:self.needTextView];
        [_appointmentView addSubview:self.tipsView];
        [_appointmentView addSubview:self.commitButton];
        
        [_appointmentView setFrame:CGRectMake(0, 0, MainWidth, self.commitButton.frame.origin.y + self.commitButton.frame.size.height)];
    }
    return _appointmentView;
}

- (UILabel *)contactPersonLabel {
    
    if (!_contactPersonLabel) {
        _contactPersonLabel = [[UILabel alloc] init];
        _contactPersonLabel.frame = CGRectMake(20.0f, 20.0f, MainWidth - 20.0f*2, 13.0f);
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
        _contactPersonEdit.textAlignment = NSTextAlignmentCenter;
        _contactPersonEdit.backgroundColor = [UIColor whiteColor];
        _contactPersonEdit.layer.masksToBounds = YES;
        _contactPersonEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _contactPersonEdit.layer.borderWidth = 0.5f;
        _contactPersonEdit.layer.cornerRadius = 4.0f;
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
        _telphoneEdit.layer.cornerRadius = 4.0f;
        _telphoneEdit.delegate = self;
        [_telphoneEdit setTintColor:_COLOR_HEX(0x999999)];
    }
    return _telphoneEdit;
}

- (UILabel *)enterpriseNameLabel {
    
    if (!_enterpriseNameLabel) {
        _enterpriseNameLabel = [[UILabel alloc] init];
        _enterpriseNameLabel.frame = CGRectMake(20.0f, self.telphoneEdit.frame.origin.y + self.telphoneEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
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
        _enterpriseNameEdit.textAlignment = NSTextAlignmentCenter;
        _enterpriseNameEdit.backgroundColor = [UIColor whiteColor];
        _enterpriseNameEdit.layer.masksToBounds = YES;
        _enterpriseNameEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _enterpriseNameEdit.layer.borderWidth = 0.5f;
        _enterpriseNameEdit.layer.cornerRadius = 4.0f;
        _enterpriseNameEdit.delegate = self;
        [_enterpriseNameEdit setTintColor:_COLOR_HEX(0x999999)];
    }
    return _enterpriseNameEdit;
}

- (UILabel *)staffNumberLabel {
    
    if (!_staffNumberLabel) {
        _staffNumberLabel = [[UILabel alloc] init];
        _staffNumberLabel.frame = CGRectMake(20.0f, self.enterpriseNameEdit.frame.origin.y + self.enterpriseNameEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _staffNumberLabel.font = [UIFont systemFontOfSize:13.0f];
        _staffNumberLabel.textColor = _COLOR_HEX(0x333333);
        _staffNumberLabel.textAlignment = NSTextAlignmentLeft;
        _staffNumberLabel.text = @"企业人数";
    }
    return _staffNumberLabel;
}

- (UITextField *)staffNumberEdit {
    
    if (!_staffNumberEdit) {
        _staffNumberEdit = [[UITextField alloc] init];
        _staffNumberEdit.frame = CGRectMake(20.0f, self.staffNumberLabel.frame.origin.y + self.staffNumberLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        _staffNumberEdit.textAlignment = NSTextAlignmentCenter;
        _staffNumberEdit.backgroundColor = [UIColor whiteColor];
        _staffNumberEdit.layer.masksToBounds = YES;
        _staffNumberEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _staffNumberEdit.layer.borderWidth = 0.5f;
        _staffNumberEdit.layer.cornerRadius = 4.0f;
        _staffNumberEdit.delegate = self;
        [_staffNumberEdit setTintColor:_COLOR_HEX(0x999999)];
    }
    return _staffNumberEdit;
}

- (UILabel *)needLabel {
    
    if(!_needLabel) {
        _needLabel = [[UILabel alloc] init];
        _needLabel.frame = CGRectMake(20.0f, self.staffNumberEdit.frame.origin.y + self.staffNumberEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _needLabel.font = [UIFont systemFontOfSize:13.0f];
        _needLabel.textColor = _COLOR_HEX(0x333333);
        _needLabel.textAlignment = NSTextAlignmentLeft;
        _needLabel.text = @"补充说明";
    }
    return _needLabel;
}

- (PlaceholderTextView *)needTextView {
    
    if (!_needTextView) {
        _needTextView = [[PlaceholderTextView alloc] init];
        _needTextView.frame = CGRectMake(20.0f, self.needLabel.frame.origin.y + self.needLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 150.0f);
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
        _needTextView.layer.cornerRadius = 4.0f;
        _needTextView.delegate = self;
        [_needTextView addSubview:self.limitTipsLable];
    }
    return _needTextView;
}

- (UILabel *)limitTipsLable {
    if (!_limitTipsLable) {
        _limitTipsLable = [[UILabel alloc] init];
        _limitTipsLable.frame = CGRectMake(MainWidth - 20.0f*2.0f - 14.0f*2.0f - 100.0f, 150.0f - 15.0f - 19.0f, 100.0f, 19.0f);
        _limitTipsLable.font = [UIFont systemFontOfSize:13.0f];
        _limitTipsLable.textColor = _COLOR_HEX(0xcccccc);
        _limitTipsLable.textAlignment = NSTextAlignmentRight;
        _limitTipsLable.text = @"限2000字";
    }
    return _limitTipsLable;
}

- (UIView *)tipsView {
    if (!_tipsView) {
        _tipsView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, self.needTextView.frame.origin.y + self.needTextView.frame.size.height + 15.0f, MainWidth, 100.0f)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0f, 15.0f, 70.0f * 270 / 138, 70.0f)];
        [imageView setImage:__IMAGENAMED__(@"img_yuyuekanfang")];
        [_tipsView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 5, 15.0f, _tipsView.frame.size.width - (imageView.frame.origin.x + imageView.frame.size.width + 5) - 5.0f, 70.0f)];
        [label setText:@"填写太繁琐，那就直接提交委托吧！\n客服将拨打您的手机号进行回访,\n坐等电话就可以了。"];
        [label setTextColor:_Colorhex(0xff8830)];
        [label setFont:[UIFont systemFontOfSize:12.0f]];
        [label setNumberOfLines:3];
        [_tipsView addSubview:label];
    }
    return _tipsView;
}

- (UIButton *)commitButton {
    
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] init];
        _commitButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, self.tipsView.frame.origin.y + self.tipsView.frame.size.height + 15.0f, MainWidth, 49.0f)];
        _commitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//        _commitButton.layer.cornerRadius = 10.0f;
        [_commitButton setBackgroundColor:_COLOR_HEX(0x00c78c)];
        [_commitButton setTitle:@"提交申请" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (void)commitAction:(UIButton *)button {
    
    if ([self.telphoneEdit.text isEqualToString:@""]) {
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
        [self productSubscribe];
    }
}

- (void)productSubscribe {
    
    dispatch_group_enter(requestGroup);
    
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *orderType = self.orderType ?:@"";
    NSString *productId = self.productId ?:@"";
    NSString *quantity = self.quantity;
    if (quantity == nil) {
        quantity = @"1";
    }
    NSDictionary *dic = @{
                          @"partyId" : partyId,
                          @"orderType" : orderType,
                          @"productId" : productId,
                          @"quantity" : quantity,
                          @"contact" : self.contactPersonEdit.text?:@"",
                          @"contactNumber" : self.telphoneEdit.text,
                          @"enterpriseName": self.enterpriseNameEdit.text?:@"",
                          @"enterpriseScale": self.staffNumberEdit.text?:@"",
                          @"remark" : self.needTextView.text,
                          };
 
    NSString *jsonString = [VSPageRoute dictionaryToJson:dic];
    dic = @{@"content":jsonString};
    
    __weak typeof(self)weakself = self;
    [self vs_showLoading];
    [BCNetWorkTool executePostNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/product-subscribe/version/1.5.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        [weakself.view showTipsView:@"预约成功"];
        [weakself vs_hideLoadingWithCompleteBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        [weakself.view showTipsView:[callBackData domain]];
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        dispatch_group_leave(requestGroup);
    }];
}

@end
