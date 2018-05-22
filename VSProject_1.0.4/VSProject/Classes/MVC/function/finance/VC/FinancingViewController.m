//
//  FinancingViewController.m
//  VSProject
//
//  Created by pangchao on 17/1/5.
//  Copyright © 2017年 user. All rights reserved.
//

#import "FinancingViewController.h"
#import "PlaceholderTextView.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "BCNetWorkTool.h"

@interface FinancingViewController () <UITextFieldDelegate, UITextViewDelegate>
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

@property (nonatomic, strong) UILabel *zhiZhaoLabel;  // 营业执照号
@property (nonatomic, strong) UITextField *zhiZhaoEdit; // 营业执照号输出

@property (nonatomic, strong) UILabel *yinHangLabel;  // 开户银行
@property (nonatomic, strong) UITextField *yinHangEdit; // 开户银行输出

@property (nonatomic, strong) UILabel *zhangHaoLabel;  // 开户账号
@property (nonatomic, strong) UITextField *zhangHaoEdit; // 开户账号输出

@property (nonatomic, strong) UILabel *projectNameLabel; // 融资项目名称
@property (nonatomic, strong) UITextField *projectNameEdit; // 融资项目输入

@property (nonatomic, strong) UILabel *jinELabel; // 募资金额
@property (nonatomic, strong) UITextField *jinEEdit; // 募资金额输入

@property (nonatomic, strong) UILabel *qiXianELabel; // 投资期限
@property (nonatomic, strong) UITextField *qiXianEdit; // 投资期限输入

@property (nonatomic, strong) UILabel *liLvLabel; // 年化利率
@property (nonatomic, strong) UITextField *liLvEdit; // 年化利率输入

@property (nonatomic, strong) UIButton *commitButton; // 提交按钮

@end

@implementation FinancingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"债权融资信息填写"];
    
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
        
        [_appointmentView addSubview:self.zhiZhaoLabel];  // 营业执照号
        [_appointmentView addSubview:self.zhiZhaoEdit]; // 营业执照号输出
        
        [_appointmentView addSubview:self.yinHangLabel];  // 开户银行
        [_appointmentView addSubview:self.yinHangEdit]; // 开户银行输出
        
        [_appointmentView addSubview:self.zhangHaoLabel];  // 开户账号
        [_appointmentView addSubview:self.zhangHaoEdit]; // 开户账号输出
        
        [_appointmentView addSubview:self.projectNameLabel];
        [_appointmentView addSubview:self.projectNameEdit];
        
        [_appointmentView addSubview:self.jinELabel]; // 募资金额
        [_appointmentView addSubview:self.jinEEdit]; // 募资金额输入
        
        [_appointmentView addSubview:self.qiXianELabel]; // 投资期限
        [_appointmentView addSubview:self.qiXianEdit]; // 投资期限输入
        
        [_appointmentView addSubview:self.liLvLabel]; // 年化利率
        [_appointmentView addSubview:self.liLvEdit]; // 年化利率输入
        
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

- (UILabel *)zhiZhaoLabel {
    
    if (!_zhiZhaoLabel) {
        _zhiZhaoLabel = [[UILabel alloc] init];
        _zhiZhaoLabel.frame = CGRectMake(20.0f, self.enterpriseNameEdit.frame.origin.y + self.enterpriseNameEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _zhiZhaoLabel.font = [UIFont systemFontOfSize:13.0f];
        _zhiZhaoLabel.textColor = _COLOR_HEX(0x333333);
        _zhiZhaoLabel.textAlignment = NSTextAlignmentLeft;
        _zhiZhaoLabel.text = @"营业执照号";
    }
    return _zhiZhaoLabel;
}

- (UITextField *)zhiZhaoEdit {
    
    if (!_zhiZhaoEdit) {
        _zhiZhaoEdit = [[UITextField alloc] init];
        _zhiZhaoEdit.frame = CGRectMake(20.0f, self.zhiZhaoLabel.frame.origin.y + self.zhiZhaoLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _zhiZhaoEdit.attributedPlaceholder = placeHolder;
        _zhiZhaoEdit.textAlignment = NSTextAlignmentCenter;
        _zhiZhaoEdit.backgroundColor = [UIColor whiteColor];
        _zhiZhaoEdit.layer.masksToBounds = YES;
        _zhiZhaoEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _zhiZhaoEdit.layer.borderWidth = 0.5f;
        _zhiZhaoEdit.layer.cornerRadius = 10.0f;
        [_zhiZhaoEdit setTintColor:_COLOR_HEX(0x999999)];
        _zhiZhaoEdit.delegate = self;
    }
    return _zhiZhaoEdit;
}

- (UILabel *)yinHangLabel {
    
    if (!_yinHangLabel) {
        _yinHangLabel = [[UILabel alloc] init];
        _yinHangLabel.frame = CGRectMake(20.0f, self.zhiZhaoEdit.frame.origin.y + self.zhiZhaoEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _yinHangLabel.font = [UIFont systemFontOfSize:13.0f];
        _yinHangLabel.textColor = _COLOR_HEX(0x333333);
        _yinHangLabel.textAlignment = NSTextAlignmentLeft;
        _yinHangLabel.text = @"开户银行";
    }
    return _yinHangLabel;
}

- (UITextField *)yinHangEdit {
    
    if (!_yinHangEdit) {
        _yinHangEdit = [[UITextField alloc] init];
        _yinHangEdit.frame = CGRectMake(20.0f, self.yinHangLabel.frame.origin.y + self.yinHangLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _yinHangEdit.attributedPlaceholder = placeHolder;
        _yinHangEdit.textAlignment = NSTextAlignmentCenter;
        _yinHangEdit.backgroundColor = [UIColor whiteColor];
        _yinHangEdit.layer.masksToBounds = YES;
        _yinHangEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _yinHangEdit.layer.borderWidth = 0.5f;
        _yinHangEdit.layer.cornerRadius = 10.0f;
        [_yinHangEdit setTintColor:_COLOR_HEX(0x999999)];
        _yinHangEdit.delegate = self;
    }
    return _yinHangEdit;
}

- (UILabel *)zhangHaoLabel {
    
    if (!_zhangHaoLabel) {
        _zhangHaoLabel = [[UILabel alloc] init];
        _zhangHaoLabel.frame = CGRectMake(20.0f, self.yinHangEdit.frame.origin.y + self.yinHangEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _zhangHaoLabel.font = [UIFont systemFontOfSize:13.0f];
        _zhangHaoLabel.textColor = _COLOR_HEX(0x333333);
        _zhangHaoLabel.textAlignment = NSTextAlignmentLeft;
        _zhangHaoLabel.text = @"开户账号";
    }
    return _zhangHaoLabel;
}

- (UITextField *)zhangHaoEdit {
    
    if (!_zhangHaoEdit) {
        _zhangHaoEdit = [[UITextField alloc] init];
        _zhangHaoEdit.frame = CGRectMake(20.0f, self.zhangHaoLabel.frame.origin.y + self.zhangHaoLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _zhangHaoEdit.attributedPlaceholder = placeHolder;
        _zhangHaoEdit.textAlignment = NSTextAlignmentCenter;
        _zhangHaoEdit.backgroundColor = [UIColor whiteColor];
        _zhangHaoEdit.layer.masksToBounds = YES;
        _zhangHaoEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _zhangHaoEdit.layer.borderWidth = 0.5f;
        _zhangHaoEdit.layer.cornerRadius = 10.0f;
        [_zhangHaoEdit setTintColor:_COLOR_HEX(0x999999)];
        _zhangHaoEdit.delegate = self;
        [_zhangHaoEdit setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return _zhangHaoEdit;
}

- (UILabel *)projectNameLabel {
    
    if (!_projectNameLabel) {
        _projectNameLabel = [[UILabel alloc] init];
        _projectNameLabel.frame = CGRectMake(20.0f, self.zhangHaoEdit.frame.origin.y + self.zhangHaoEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _projectNameLabel.font = [UIFont systemFontOfSize:13.0f];
        _projectNameLabel.textColor = _COLOR_HEX(0x333333);
        _projectNameLabel.textAlignment = NSTextAlignmentLeft;
        _projectNameLabel.text = @"融资项目名称";
    }
    return _projectNameLabel;
}

- (UITextField *)projectNameEdit {
    
    if (!_projectNameEdit) {
        _projectNameEdit = [[UITextField alloc] init];
        _projectNameEdit.frame = CGRectMake(20.0f, self.projectNameLabel.frame.origin.y + self.projectNameLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _projectNameEdit.attributedPlaceholder = placeHolder;
        _projectNameEdit.textAlignment = NSTextAlignmentCenter;
        _projectNameEdit.backgroundColor = [UIColor whiteColor];
        _projectNameEdit.layer.masksToBounds = YES;
        _projectNameEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _projectNameEdit.layer.borderWidth = 0.5f;
        _projectNameEdit.layer.cornerRadius = 10.0f;
        [_projectNameEdit setTintColor:_COLOR_HEX(0x999999)];
        _projectNameEdit.delegate = self;
    }
    return _projectNameEdit;
}

- (UILabel *)jinELabel {
    
    if (!_jinELabel) {
        _jinELabel = [[UILabel alloc] init];
        _jinELabel.frame = CGRectMake(20.0f, self.projectNameEdit.frame.origin.y + self.projectNameEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _jinELabel.font = [UIFont systemFontOfSize:13.0f];
        _jinELabel.textColor = _COLOR_HEX(0x333333);
        _jinELabel.textAlignment = NSTextAlignmentLeft;
        _jinELabel.text = @"募资金额";
    }
    return _jinELabel;
}

- (UITextField *)jinEEdit {
    
    if (!_jinEEdit) {
        _jinEEdit = [[UITextField alloc] init];
        _jinEEdit.frame = CGRectMake(20.0f, self.jinELabel.frame.origin.y + self.jinELabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _jinEEdit.attributedPlaceholder = placeHolder;
        _jinEEdit.textAlignment = NSTextAlignmentCenter;
        _jinEEdit.backgroundColor = [UIColor whiteColor];
        _jinEEdit.layer.masksToBounds = YES;
        _jinEEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _jinEEdit.layer.borderWidth = 0.5f;
        _jinEEdit.layer.cornerRadius = 10.0f;
        [_jinEEdit setTintColor:_COLOR_HEX(0x999999)];
        _jinEEdit.delegate = self;
        [_jinEEdit setKeyboardType:UIKeyboardTypeDecimalPad];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_jinEEdit.frame.size.width - 40, 0, 40, _jinEEdit.frame.size.height)];
        [label setTextColor:[UIColor blackColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setText:@"万元"];
        [_jinEEdit addSubview:label];
    }
    return _jinEEdit;
}

- (UILabel *)qiXianELabel {
    
    if (!_qiXianELabel) {
        _qiXianELabel = [[UILabel alloc] init];
        _qiXianELabel.frame = CGRectMake(20.0f, self.jinEEdit.frame.origin.y + self.jinEEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _qiXianELabel.font = [UIFont systemFontOfSize:13.0f];
        _qiXianELabel.textColor = _COLOR_HEX(0x333333);
        _qiXianELabel.textAlignment = NSTextAlignmentLeft;
        _qiXianELabel.text = @"投资期限";
    }
    return _qiXianELabel;
}

- (UITextField *)qiXianEdit {
    
    if (!_qiXianEdit) {
        _qiXianEdit = [[UITextField alloc] init];
        _qiXianEdit.frame = CGRectMake(20.0f, self.qiXianELabel.frame.origin.y + self.qiXianELabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _qiXianEdit.attributedPlaceholder = placeHolder;
        _qiXianEdit.textAlignment = NSTextAlignmentCenter;
        _qiXianEdit.backgroundColor = [UIColor whiteColor];
        _qiXianEdit.layer.masksToBounds = YES;
        _qiXianEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _qiXianEdit.layer.borderWidth = 0.5f;
        _qiXianEdit.layer.cornerRadius = 10.0f;
        [_qiXianEdit setTintColor:_COLOR_HEX(0x999999)];
        _qiXianEdit.delegate = self;
        [_qiXianEdit setKeyboardType:UIKeyboardTypeNumberPad];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_qiXianEdit.frame.size.width - 25, 0, 25, _qiXianEdit.frame.size.height)];
        [label setTextColor:[UIColor blackColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setText:@"天"];
        [_qiXianEdit addSubview:label];
    }
    return _qiXianEdit;
}

- (UILabel *)liLvLabel {
    
    if (!_liLvLabel) {
        _liLvLabel = [[UILabel alloc] init];
        _liLvLabel.frame = CGRectMake(20.0f, self.qiXianEdit.frame.origin.y + self.qiXianEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _liLvLabel.font = [UIFont systemFontOfSize:13.0f];
        _liLvLabel.textColor = _COLOR_HEX(0x333333);
        _liLvLabel.textAlignment = NSTextAlignmentLeft;
        _liLvLabel.text = @"年化利率";
    }
    return _liLvLabel;
}

- (UITextField *)liLvEdit {
    
    if (!_liLvEdit) {
        _liLvEdit = [[UITextField alloc] init];
        _liLvEdit.frame = CGRectMake(20.0f, self.liLvLabel.frame.origin.y + self.liLvLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _liLvEdit.attributedPlaceholder = placeHolder;
        _liLvEdit.textAlignment = NSTextAlignmentCenter;
        _liLvEdit.backgroundColor = [UIColor whiteColor];
        _liLvEdit.layer.masksToBounds = YES;
        _liLvEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _liLvEdit.layer.borderWidth = 0.5f;
        _liLvEdit.layer.cornerRadius = 10.0f;
        [_liLvEdit setTintColor:_COLOR_HEX(0x999999)];
        _liLvEdit.delegate = self;
        [_liLvEdit setKeyboardType:UIKeyboardTypeDecimalPad];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_liLvEdit.frame.size.width - 25, 0, 25, _liLvEdit.frame.size.height)];
        [label setTextColor:[UIColor blackColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setText:@"%"];
        [_liLvEdit addSubview:label];
    }
    return _liLvEdit;
}

- (UIButton *)commitButton {
    
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] init];
        _commitButton.frame = CGRectMake(20.0f, self.liLvEdit.frame.origin.y + self.liLvEdit.frame.size.height + 30.0f, MainWidth - 20.0f*2, 44.0f);
        _commitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _commitButton.backgroundColor = [UIColor whiteColor];
        [_commitButton setTitle:@"我要债权融资" forState:UIControlStateNormal];
        _commitButton.layer.cornerRadius = 10.0f;
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton setBackgroundColor:_COLOR_HEX(0x00c78c)];
        
        [_commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (void)commitAction:(UIButton *)button {
    if ([self.contactPersonEdit.text isEqualToString:@""] || [self.telphoneEdit.text isEqualToString:@""] || [self.projectNameEdit.text isEqualToString:@""]|| [self.enterpriseNameEdit.text isEqualToString:@""]|| [self.zhiZhaoEdit.text isEqualToString:@""]|| [self.yinHangEdit.text isEqualToString:@""]|| [self.zhangHaoEdit.text isEqualToString:@""]|| [self.jinEEdit.text isEqualToString:@""]|| [self.qiXianEdit.text isEqualToString:@""]|| [self.liLvEdit.text isEqualToString:@""]) {
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
    NSString *corporateFinance = self.projectNameEdit.text;  // 项目名称
    NSDictionary *dic = @{
                          @"partyId" : partyId,
                          @"cooperationType" : @"410",
                          @"contact" : contact,
                          @"contactNumber" : contactNumber,
                          @"enterpriseName" : self.enterpriseNameEdit.text,
                          @"businessLicenseNo" : self.zhiZhaoEdit.text,
                          @"bankAccount" : self.yinHangEdit.text,
                          @"account" : self.zhangHaoEdit.text,
                          @"financingItemName" : corporateFinance,
                          @"raisingAmount" : self.jinEEdit.text,
                          @"termOfInvestment" : self.qiXianEdit.text,
                          @"annualizedRate" : self.liLvEdit.text,
                          };
    
    NSString *jsonString = [VSPageRoute dictionaryToJson:dic];
    dic = @{@"content":jsonString};

    __weak typeof(self)weakself = self;
    [self vs_showLoading];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.home/cooperation-apply/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executePostNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
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
        self.projectNameLabel.text.length > 0) {
        
        if (self.telphoneEdit.text.length == 11 && [self.telphoneEdit.text hasPrefix:@"1"]) {
            [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.commitButton setEnabled:YES];
        }
    }
}


@end
