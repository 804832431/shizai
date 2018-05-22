//
//  GuQuanRongZiViewController.m
//  VSProject
//
//  Created by apple on 3/19/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "GuQuanRongZiViewController.h"
#import "PlaceholderTextView.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "BCNetWorkTool.h"
#import "SinglePickerView.h"

@interface GuQuanRongZiViewController ()<UITextFieldDelegate, UITextViewDelegate>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIView *appointmentView; // 存放所有控件
@property (nonatomic, strong) UIScrollView *appointmentScrollView;

@property (nonatomic, strong) UILabel *contactPersonLabel; // 联系人
@property (nonatomic, strong) UITextField *contactPersonEdit; // 联系人输入

@property (nonatomic, strong) UILabel *telphoneLabel;  // 联系电话
@property (nonatomic, strong) UITextField *telphoneEdit; // 联系电话输出

@property (nonatomic, strong) UILabel *enterpriseNameLabel;  // 企业名称
@property (nonatomic, strong) UITextField *enterpriseNameEdit; // 企业名称输出

@property (nonatomic, strong) UILabel *hangYeLabel;  // 所属行业
@property (nonatomic, strong) UITextField *hangYeEdit; // 所属行业输出

@property (nonatomic, strong) UILabel *jieDuanLabel;  // 企业阶段
@property (nonatomic, strong) UITextField *jieDuanEdit; // 企业阶段输出
@property (nonatomic, strong) SinglePickerView *jieDuanPickerView;

@property (nonatomic, strong) UILabel *guQuanLabel;  //出让股权比例
@property (nonatomic, strong) UITextField *guQuanEdit;

@property (nonatomic, strong) UIView *tipsView;
@property (nonatomic, strong) UIView *flagView;
@property (nonatomic, strong) UILabel *mailLabel;


@property (nonatomic, strong) UIButton *commitButton; // 提交按钮@end

@property (nonatomic, strong) UIButton *blackClearBackGroundButton;

@end

@implementation GuQuanRongZiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"股权融资信息填写"];
    
    requestGroup = dispatch_group_create();
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - 64.0f)];
    [scrollView setContentSize:self.appointmentView.frame.size];
    [scrollView addSubview:self.appointmentView];
    
    [self.view addSubview:scrollView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeSelectTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIView *)appointmentView {
    
    if (!_appointmentView) {
        _appointmentView = [[UIView alloc] init];
        _appointmentView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f);
        _appointmentView.backgroundColor = [UIColor whiteColor];
        
        [_appointmentView addSubview:self.contactPersonLabel];
        [_appointmentView addSubview:self.contactPersonEdit];
        
        [_appointmentView addSubview:self.telphoneLabel];
        [_appointmentView addSubview:self.telphoneEdit];
        
        [_appointmentView addSubview:self.enterpriseNameLabel];  // 企业名称
        [_appointmentView addSubview:self.enterpriseNameEdit]; // 企业名称输出
        
        [_appointmentView addSubview:self.hangYeLabel];
        [_appointmentView addSubview:self.hangYeEdit];
        
        [_appointmentView addSubview:self.jieDuanLabel];
        [_appointmentView addSubview:self.jieDuanEdit];
        
        [_appointmentView addSubview:self.guQuanLabel];
        [_appointmentView addSubview:self.guQuanEdit];
        
        [_appointmentView addSubview:self.tipsView];
        
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
        [_telphoneEdit setKeyboardType:UIKeyboardTypeNumberPad];
        _telphoneEdit.delegate = self;
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
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _enterpriseNameEdit.attributedPlaceholder = placeHolder;
        _enterpriseNameEdit.textAlignment = NSTextAlignmentCenter;
        _enterpriseNameEdit.backgroundColor = [UIColor whiteColor];
        _enterpriseNameEdit.layer.masksToBounds = YES;
        _enterpriseNameEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _enterpriseNameEdit.layer.borderWidth = 0.5f;
        _enterpriseNameEdit.layer.cornerRadius = 10.0f;
        [_enterpriseNameEdit setTintColor:_COLOR_HEX(0x999999)];
        _enterpriseNameEdit.delegate = self;
    }
    return _enterpriseNameEdit;
}

- (UILabel *)hangYeLabel {
    
    if (!_hangYeLabel) {
        _hangYeLabel = [[UILabel alloc] init];
        _hangYeLabel.frame = CGRectMake(20.0f, self.enterpriseNameEdit.frame.origin.y + self.enterpriseNameEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _hangYeLabel.font = [UIFont systemFontOfSize:13.0f];
        _hangYeLabel.textColor = _COLOR_HEX(0x333333);
        _hangYeLabel.textAlignment = NSTextAlignmentLeft;
        _hangYeLabel.text = @"所属行业";
    }
    return _hangYeLabel;
}

- (UITextField *)hangYeEdit {
    
    if (!_hangYeEdit) {
        _hangYeEdit = [[UITextField alloc] init];
        _hangYeEdit.frame = CGRectMake(20.0f, self.hangYeLabel.frame.origin.y + self.hangYeLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _hangYeEdit.attributedPlaceholder = placeHolder;
        _hangYeEdit.textAlignment = NSTextAlignmentCenter;
        _hangYeEdit.backgroundColor = [UIColor whiteColor];
        _hangYeEdit.layer.masksToBounds = YES;
        _hangYeEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _hangYeEdit.layer.borderWidth = 0.5f;
        _hangYeEdit.layer.cornerRadius = 10.0f;
        [_hangYeEdit setTintColor:_COLOR_HEX(0x999999)];
        _hangYeEdit.delegate = self;
    }
    return _hangYeEdit;
}

- (UILabel *)jieDuanLabel {
    
    if (!_jieDuanLabel) {
        _jieDuanLabel = [[UILabel alloc] init];
        _jieDuanLabel.frame = CGRectMake(20.0f, self.hangYeEdit.frame.origin.y + self.hangYeEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _jieDuanLabel.font = [UIFont systemFontOfSize:13.0f];
        _jieDuanLabel.textColor = _COLOR_HEX(0x333333);
        _jieDuanLabel.textAlignment = NSTextAlignmentLeft;
        _jieDuanLabel.text = @"企业阶段";
    }
    return _jieDuanLabel;
}

- (UITextField *)jieDuanEdit {
    
    if (!_jieDuanEdit) {
        _jieDuanEdit = [[UITextField alloc] init];
        _jieDuanEdit.frame = CGRectMake(20.0f, self.jieDuanLabel.frame.origin.y + self.jieDuanLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _jieDuanEdit.attributedPlaceholder = placeHolder;
        _jieDuanEdit.textAlignment = NSTextAlignmentCenter;
        _jieDuanEdit.backgroundColor = [UIColor whiteColor];
        _jieDuanEdit.layer.masksToBounds = YES;
        _jieDuanEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _jieDuanEdit.layer.borderWidth = 0.5f;
        _jieDuanEdit.layer.cornerRadius = 10.0f;
        [_jieDuanEdit setTintColor:_COLOR_HEX(0x999999)];
        _jieDuanEdit.delegate = self;
        
        UIButton *dropButton = [[UIButton alloc] init];
        dropButton.frame = CGRectMake(MainWidth - 20.0f*2 - 28.0f, 0, 28.0f, 44.0f);
        dropButton.backgroundColor = [UIColor clearColor];
        [dropButton addTarget:self action:@selector(dropAction:) forControlEvents:UIControlEventTouchUpInside];
        dropButton.selected = NO;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, 28.0f, 44.0f);
        imageView.image = [UIImage imageNamed:@"list_drop_but"];
        [dropButton addSubview:imageView];
        
        UIButton *clearButton = [[UIButton alloc] init];
        clearButton.frame = _jieDuanEdit.bounds;
        clearButton.backgroundColor = [UIColor clearColor];
        [clearButton addTarget:self action:@selector(dropAction:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.selected = NO;
        
        [_jieDuanEdit addSubview:dropButton];
        [_jieDuanEdit addSubview:clearButton];
    }
    return _jieDuanEdit;
}

- (SinglePickerView *)jieDuanPickerView {
    if (!_jieDuanPickerView) {
        _jieDuanPickerView = [[SinglePickerView alloc] initWithFrame:self.view.frame pickerViewType:PICKER_NORMAL];
        [_jieDuanPickerView.accessoryView.cancelBtn setHidden:YES];
        UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelectTableView)];
        [_jieDuanPickerView addGestureRecognizer:singleTap1];
        _jieDuanPickerView.dataList = @[@"初创",@"天使",@"A轮"];;
    }
    return _jieDuanPickerView;
}

- (void)dropAction:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.jieDuanPickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [self.jieDuanPickerView show];
    }
    else {
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

- (UILabel *)guQuanLabel {
    
    if (!_guQuanLabel) {
        _guQuanLabel = [[UILabel alloc] init];
        _guQuanLabel.frame = CGRectMake(20.0f, self.jieDuanEdit.frame.origin.y + self.jieDuanEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _guQuanLabel.font = [UIFont systemFontOfSize:13.0f];
        _guQuanLabel.textColor = _COLOR_HEX(0x333333);
        _guQuanLabel.textAlignment = NSTextAlignmentLeft;
        _guQuanLabel.text = @"出让股权比例";
    }
    return _guQuanLabel;
}

- (UITextField *)guQuanEdit {
    
    if (!_guQuanEdit) {
        _guQuanEdit = [[UITextField alloc] init];
        _guQuanEdit.frame = CGRectMake(20.0f, self.guQuanLabel.frame.origin.y + self.guQuanLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _guQuanEdit.attributedPlaceholder = placeHolder;
        _guQuanEdit.textAlignment = NSTextAlignmentCenter;
        _guQuanEdit.backgroundColor = [UIColor whiteColor];
        _guQuanEdit.layer.masksToBounds = YES;
        _guQuanEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _guQuanEdit.layer.borderWidth = 0.5f;
        _guQuanEdit.layer.cornerRadius = 10.0f;
        [_guQuanEdit setTintColor:_COLOR_HEX(0x999999)];
        _guQuanEdit.delegate = self;
        [_guQuanEdit setKeyboardType:UIKeyboardTypeDecimalPad];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_guQuanEdit.frame.size.width - 25, 0, 25, _guQuanEdit.frame.size.height)];
        [label setTextColor:[UIColor blackColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setText:@"%"];
        [_guQuanEdit addSubview:label];

    }
    return _guQuanEdit;
}

- (UIView *)tipsView {
    
    if (!_tipsView) {
        _tipsView = [[UIView alloc] init];
        _tipsView.frame = CGRectMake(20.0f, self.guQuanEdit.frame.origin.y + self.guQuanEdit.frame.size.height + 20.0f, MainWidth - 20.0f*2, 130.0f);
        _tipsView.layer.masksToBounds = YES;
        _tipsView.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _tipsView.layer.borderWidth = 0.5f;
        _tipsView.layer.cornerRadius = 10.0f;
        
        [_tipsView addSubview:self.flagView];
        [_tipsView addSubview:self.mailLabel];
    }
    return _tipsView;
}

- (UIView *)flagView {
    
    if (!_flagView) {
        _flagView = [[UIView alloc] init];
        _flagView.frame = CGRectMake((MainWidth - 120.0f)/2 - 20, 15.0f, 120.0f, 25.0f);
        _flagView.backgroundColor = [UIColor clearColor];
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.frame = CGRectMake(0, 0, 75.0f, 23.0f);
        leftLabel.font = [UIFont systemFontOfSize:22.0f];
        leftLabel.backgroundColor = _COLOR_HEX(0x00c78c);
        leftLabel.textColor = [UIColor whiteColor];
        leftLabel.text = @"上传BP";
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.frame = CGRectMake(75.0f, 0, 45.0f, 23.0f);
        rightLabel.font = [UIFont systemFontOfSize:22.0f];
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.layer.masksToBounds = YES;
        rightLabel.layer.borderColor = _COLOR_HEX(0x00c78c).CGColor;
        rightLabel.layer.borderWidth = 0.5f;
        rightLabel.textColor = _COLOR_HEX(0x00c78c);
        rightLabel.text = @"提示";
        
        [_flagView addSubview:leftLabel];
        [_flagView addSubview:rightLabel];
    }
    return _flagView;
}

- (UILabel *)mailLabel {
    
    if (!_mailLabel) {
        _mailLabel = [[UILabel alloc] init];
        _mailLabel.frame = CGRectMake(17.0f, self.flagView.frame.origin.y + self.flagView.frame.size.height + 18.0f, MainWidth - 17.0f*2, 60.0f);
        _mailLabel.font = [UIFont systemFontOfSize:15.0f];
        _mailLabel.textColor = _COLOR_HEX(0x464646);
        _mailLabel.textAlignment = NSTextAlignmentLeft;
        _mailLabel.numberOfLines = 0;
        _mailLabel.text = @"您可以发送BP至：zhanglu@rtianxia.com\n\n通过审核后我们将与您联系，为您配对投资人";
    }
    return _mailLabel;
}


- (UIButton *)commitButton {
    
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] init];
        _commitButton.frame = CGRectMake(20.0f, self.tipsView.frame.origin.y + self.tipsView.frame.size.height + 30.0f, MainWidth - 20.0f*2, 44.0f);
        _commitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _commitButton.backgroundColor = [UIColor whiteColor];
        [_commitButton setTitle:@"我要股权融资" forState:UIControlStateNormal];
        _commitButton.layer.cornerRadius = 10.0f;
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton setBackgroundColor:_COLOR_HEX(0x00c78c)];
        
        [_commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

#pragma mark - SinglePickerViewDelegate
- (void)SinglePickerView:(SinglePickerView *)pickerView selectedValue:(NSString *)selectedValue {
    if (selectedValue) {
        if ([pickerView isEqual:self.jieDuanPickerView]) {
            self.jieDuanEdit.text = selectedValue;
        }
    }
}

- (void)removeSelectTableView {
    [self.blackClearBackGroundButton removeFromSuperview];
    [_jieDuanPickerView hide];
}

- (UIButton *)blackClearBackGroundButton {
    if (!_blackClearBackGroundButton) {
        _blackClearBackGroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__)];
        [_blackClearBackGroundButton setBackgroundColor:ColorWithHex(0x000000, 0.6)];
        [_blackClearBackGroundButton addTarget:self action:@selector(removeSelectTableView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blackClearBackGroundButton;
}

#pragma mark - Commit action
- (void)commitAction:(UIButton *)button {
    if ([self.contactPersonEdit.text isEqualToString:@""] || [self.telphoneEdit.text isEqualToString:@""] || [self.enterpriseNameEdit.text isEqualToString:@""]|| [self.hangYeEdit.text isEqualToString:@""]|| [self.jieDuanEdit.text isEqualToString:@""]|| [self.guQuanEdit.text isEqualToString:@""]) {
        [self.view showTipsView:@"亲~你还有信息未填写哦~"];
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
    NSString *contactNumber = self.telphoneEdit.text;  // 联系方式
    NSDictionary *dic = @{
                          @"partyId" : partyId,
                          @"cooperationType" : @"411",
                          @"contact" : contact,
                          @"contactNumber" : contactNumber,
                          @"enterpriseName" : self.enterpriseNameEdit.text,
                          @"subordinateIndustry" : self.hangYeEdit.text,
                          @"enterpriseStage" : self.jieDuanEdit.text,
                          @"equityRatio" : self.guQuanEdit.text,
                          @"uploadBusinessPlan" : @"",
                          };
    
    NSString *jsonString = [VSPageRoute dictionaryToJson:dic];
    dic = @{@"content":jsonString};
    
    __weak typeof(self)weakself = self;
    [self vs_showLoading];
    [BCNetWorkTool executePostNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.home/cooperation-apply/version/1.5.1" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        [weakself.view showTipsView:@"申请已经提交成功,\n请耐心等待工作人员审核"];
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

@end
