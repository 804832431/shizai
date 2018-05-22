//
//  QiYeDaiKuanViewController.m
//  VSProject
//
//  Created by apple on 3/19/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "QiYeDaiKuanViewController.h"
#import "PlaceholderTextView.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "BCNetWorkTool.h"
#import "SinglePickerView.h"
#import "MultiPickerView.h"

@interface QiYeDaiKuanViewController ()<UITextFieldDelegate, UITextViewDelegate>
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

@property (nonatomic, strong) UILabel *leiXingLabel;  // 企业类型
@property (nonatomic, strong) UITextField *leiXingEdit;
@property (nonatomic, strong) SinglePickerView *leiXingPickerView;

@property (nonatomic, strong) UILabel *zhiZhaoLabel;  // 营业执照号
@property (nonatomic, strong) UITextField *zhiZhaoEdit;

@property (nonatomic, strong) UILabel *fuZhaiLabel;  // 是否负债
@property (nonatomic, strong) UITextField *fuZhaiEdit;
@property (nonatomic, strong) SinglePickerView *fuZhaiPickerView;

@property (nonatomic, strong) UILabel *rongZiLabel;  // 融资类型
@property (nonatomic, strong) UITextField *rongZiEdit;
@property (nonatomic, strong) SinglePickerView *rongZiPickerView;

@property (nonatomic, strong) UILabel *yongTuLabel;  //资金用途
@property (nonatomic, strong) UITextField *yongTuEdit;

@property (nonatomic, strong) UILabel *zhouQiLabel;  // 用款周期
@property (nonatomic, strong) UITextField *zhouQiEdit;
@property (nonatomic, strong) SinglePickerView *zhouQiPickerView;

@property (nonatomic, strong) UILabel *qiXianLabel;  //办理期限
@property (nonatomic, strong) UITextField *qiXianEdit;

@property (nonatomic, strong) UILabel *jinELabel;  //贷款最高金额
@property (nonatomic, strong) UITextField *jinEEdit;

@property (nonatomic, strong) UILabel *needLabel1; // 抵押物说明
@property (nonatomic, strong) PlaceholderTextView *needTextView1;
@property (nonatomic, strong) UILabel *limitTipsLable1;

@property (nonatomic, strong) UILabel *needLabel; // 补充说明
@property (nonatomic, strong) PlaceholderTextView *needTextView;
@property (nonatomic, strong) UILabel *limitTipsLable;

@property (nonatomic, strong) UIButton *commitButton; // 提交按钮@end

@property (nonatomic, strong) UIButton *blackClearBackGroundButton;

@end

@implementation QiYeDaiKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"企业贷款信息填写"];
    
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
        
        [_appointmentView addSubview:self.leiXingLabel];  // 企业类型
        [_appointmentView addSubview:self.leiXingEdit];
        
        [_appointmentView addSubview:self.zhiZhaoLabel];  // 营业执照号
        [_appointmentView addSubview:self.zhiZhaoEdit];
        
        [_appointmentView addSubview:self.fuZhaiLabel];  // 是否负债
        [_appointmentView addSubview:self.fuZhaiEdit];
        
        [_appointmentView addSubview:self.rongZiLabel];  // 融资类型
        [_appointmentView addSubview:self.rongZiEdit];
        
        [_appointmentView addSubview:self.yongTuLabel];  //资金用途
        [_appointmentView addSubview:self.yongTuEdit];
        
        [_appointmentView addSubview:self.zhouQiLabel];  // 用款周期
        [_appointmentView addSubview:self.zhouQiEdit];
        
        [_appointmentView addSubview:self.qiXianLabel];  //办理期限
        [_appointmentView addSubview:self.qiXianEdit];
        
        [_appointmentView addSubview:self.jinELabel];  //贷款最高金额
        [_appointmentView addSubview:self.jinEEdit];
        
        [_appointmentView addSubview:self.needLabel1]; // 抵押物说明
        [_appointmentView addSubview:self.needTextView1];
        
        [_appointmentView addSubview:self.needLabel]; // 补充说明
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

- (UILabel *)leiXingLabel {
    
    if (!_leiXingLabel) {
        _leiXingLabel = [[UILabel alloc] init];
        _leiXingLabel.frame = CGRectMake(20.0f, self.enterpriseNameEdit.frame.origin.y + self.enterpriseNameEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _leiXingLabel.font = [UIFont systemFontOfSize:13.0f];
        _leiXingLabel.textColor = _COLOR_HEX(0x333333);
        _leiXingLabel.textAlignment = NSTextAlignmentLeft;
        _leiXingLabel.text = @"企业类型";
    }
    return _leiXingLabel;
}

- (UITextField *)leiXingEdit {
    
    if (!_leiXingEdit) {
        _leiXingEdit = [[UITextField alloc] init];
        _leiXingEdit.frame = CGRectMake(20.0f, self.leiXingLabel.frame.origin.y + self.leiXingLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _leiXingEdit.attributedPlaceholder = placeHolder;
        _leiXingEdit.textAlignment = NSTextAlignmentCenter;
        _leiXingEdit.backgroundColor = [UIColor whiteColor];
        _leiXingEdit.layer.masksToBounds = YES;
        _leiXingEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _leiXingEdit.layer.borderWidth = 0.5f;
        _leiXingEdit.layer.cornerRadius = 10.0f;
        [_leiXingEdit setTintColor:_COLOR_HEX(0x999999)];
        _leiXingEdit.delegate = self;
        
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
        clearButton.frame = _leiXingEdit.bounds;
        clearButton.backgroundColor = [UIColor clearColor];
        [clearButton addTarget:self action:@selector(dropAction:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.selected = NO;
        
        [_leiXingEdit addSubview:dropButton];
        [_leiXingEdit addSubview:clearButton];
    }
    return _leiXingEdit;
}

- (SinglePickerView *)leiXingPickerView {
    if (!_leiXingPickerView) {
        _leiXingPickerView = [[SinglePickerView alloc] initWithFrame:self.view.frame pickerViewType:PICKER_NORMAL];
        [_leiXingPickerView.accessoryView.cancelBtn setHidden:YES];
        UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelectTableView)];
        [_leiXingPickerView addGestureRecognizer:singleTap1];
        _leiXingPickerView.dataList = @[@"股份公司",@"有限责任公司",@"股份合作企业",@"私营企业",@"国有企业",@"个人独资企业",@"合伙企业",@"其他性质企业"];;
    }
    return _leiXingPickerView;
}

- (void)dropAction:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    [self.zhiZhaoEdit resignFirstResponder];
    [self.yongTuEdit resignFirstResponder];
    [self.qiXianEdit resignFirstResponder];
    [self.jinEEdit resignFirstResponder];
    [self.needTextView1 resignFirstResponder];
    [self.needTextView resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.leiXingPickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [self.leiXingPickerView show];
    }
    else {
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

- (UILabel *)zhiZhaoLabel {
    
    if (!_zhiZhaoLabel) {
        _zhiZhaoLabel = [[UILabel alloc] init];
        _zhiZhaoLabel.frame = CGRectMake(20.0f, self.leiXingEdit.frame.origin.y + self.leiXingEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
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

- (UILabel *)fuZhaiLabel {
    
    if (!_fuZhaiLabel) {
        _fuZhaiLabel = [[UILabel alloc] init];
        _fuZhaiLabel.frame = CGRectMake(20.0f, self.zhiZhaoEdit.frame.origin.y + self.zhiZhaoEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _fuZhaiLabel.font = [UIFont systemFontOfSize:13.0f];
        _fuZhaiLabel.textColor = _COLOR_HEX(0x333333);
        _fuZhaiLabel.textAlignment = NSTextAlignmentLeft;
        _fuZhaiLabel.text = @"是否负债";
    }
    return _fuZhaiLabel;
}

- (UITextField *)fuZhaiEdit {
    
    if (!_fuZhaiEdit) {
        _fuZhaiEdit = [[UITextField alloc] init];
        _fuZhaiEdit.frame = CGRectMake(20.0f, self.fuZhaiLabel.frame.origin.y + self.fuZhaiLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _fuZhaiEdit.attributedPlaceholder = placeHolder;
        _fuZhaiEdit.textAlignment = NSTextAlignmentCenter;
        _fuZhaiEdit.backgroundColor = [UIColor whiteColor];
        _fuZhaiEdit.layer.masksToBounds = YES;
        _fuZhaiEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _fuZhaiEdit.layer.borderWidth = 0.5f;
        _fuZhaiEdit.layer.cornerRadius = 10.0f;
        [_fuZhaiEdit setTintColor:_COLOR_HEX(0x999999)];
        _fuZhaiEdit.delegate = self;
        
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
        clearButton.frame = _fuZhaiEdit.bounds;
        clearButton.backgroundColor = [UIColor clearColor];
        [clearButton addTarget:self action:@selector(dropAction1:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.selected = NO;
        
        [_fuZhaiEdit addSubview:dropButton];
        [_fuZhaiEdit addSubview:clearButton];
    }
    return _fuZhaiEdit;
}

- (SinglePickerView *)fuZhaiPickerView {
    if (!_fuZhaiPickerView) {
        _fuZhaiPickerView = [[SinglePickerView alloc] initWithFrame:self.view.frame pickerViewType:PICKER_NORMAL];
        [_fuZhaiPickerView.accessoryView.cancelBtn setHidden:YES];
        UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelectTableView)];
        [_fuZhaiPickerView addGestureRecognizer:singleTap1];
        _fuZhaiPickerView.dataList = @[@"否",@"是"];;
    }
    return _fuZhaiPickerView;
}

- (void)dropAction1:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    [self.zhiZhaoEdit resignFirstResponder];
    [self.yongTuEdit resignFirstResponder];
    [self.qiXianEdit resignFirstResponder];
    [self.jinEEdit resignFirstResponder];
    [self.needTextView1 resignFirstResponder];
    [self.needTextView resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.fuZhaiPickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [self.fuZhaiPickerView show];
    }
    else {
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

- (UILabel *)rongZiLabel {
    
    if (!_rongZiLabel) {
        _rongZiLabel = [[UILabel alloc] init];
        _rongZiLabel.frame = CGRectMake(20.0f, self.fuZhaiEdit.frame.origin.y + self.fuZhaiEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _rongZiLabel.font = [UIFont systemFontOfSize:13.0f];
        _rongZiLabel.textColor = _COLOR_HEX(0x333333);
        _rongZiLabel.textAlignment = NSTextAlignmentLeft;
        _rongZiLabel.text = @"融资类型";
    }
    return _rongZiLabel;
}

- (UITextField *)rongZiEdit {
    
    if (!_rongZiEdit) {
        _rongZiEdit = [[UITextField alloc] init];
        _rongZiEdit.frame = CGRectMake(20.0f, self.rongZiLabel.frame.origin.y + self.rongZiLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _rongZiEdit.attributedPlaceholder = placeHolder;
        _rongZiEdit.textAlignment = NSTextAlignmentCenter;
        _rongZiEdit.backgroundColor = [UIColor whiteColor];
        _rongZiEdit.layer.masksToBounds = YES;
        _rongZiEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _rongZiEdit.layer.borderWidth = 0.5f;
        _rongZiEdit.layer.cornerRadius = 10.0f;
        [_rongZiEdit setTintColor:_COLOR_HEX(0x999999)];
        _rongZiEdit.delegate = self;
        
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
        clearButton.frame = _rongZiEdit.bounds;
        clearButton.backgroundColor = [UIColor clearColor];
        [clearButton addTarget:self action:@selector(dropAction2:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.selected = NO;
        
        [_rongZiEdit addSubview:dropButton];
        [_rongZiEdit addSubview:clearButton];
    }
    return _rongZiEdit;
}

- (SinglePickerView *)rongZiPickerView {
    if (!_rongZiPickerView) {
        _rongZiPickerView = [[SinglePickerView alloc] initWithFrame:self.view.frame pickerViewType:PICKER_NORMAL];
        [_rongZiPickerView.accessoryView.cancelBtn setHidden:YES];
        UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelectTableView)];
        [_rongZiPickerView addGestureRecognizer:singleTap1];
        _rongZiPickerView.dataList = @[@"信用贷款",@"抵押贷款"];;
    }
    return _rongZiPickerView;
}

- (void)dropAction2:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    [self.zhiZhaoEdit resignFirstResponder];
    [self.yongTuEdit resignFirstResponder];
    [self.qiXianEdit resignFirstResponder];
    [self.jinEEdit resignFirstResponder];
    [self.needTextView1 resignFirstResponder];
    [self.needTextView resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.rongZiPickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [self.rongZiPickerView show];
    }
    else {
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

- (UILabel *)yongTuLabel {
    
    if (!_yongTuLabel) {
        _yongTuLabel = [[UILabel alloc] init];
        _yongTuLabel.frame = CGRectMake(20.0f, self.rongZiEdit.frame.origin.y + self.rongZiEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _yongTuLabel.font = [UIFont systemFontOfSize:13.0f];
        _yongTuLabel.textColor = _COLOR_HEX(0x333333);
        _yongTuLabel.textAlignment = NSTextAlignmentLeft;
        _yongTuLabel.text = @"资金用途";
    }
    return _yongTuLabel;
}

- (UITextField *)yongTuEdit {
    
    if (!_yongTuEdit) {
        _yongTuEdit = [[UITextField alloc] init];
        _yongTuEdit.frame = CGRectMake(20.0f, self.yongTuLabel.frame.origin.y + self.yongTuLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _yongTuEdit.attributedPlaceholder = placeHolder;
        _yongTuEdit.textAlignment = NSTextAlignmentCenter;
        _yongTuEdit.backgroundColor = [UIColor whiteColor];
        _yongTuEdit.layer.masksToBounds = YES;
        _yongTuEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _yongTuEdit.layer.borderWidth = 0.5f;
        _yongTuEdit.layer.cornerRadius = 10.0f;
        [_yongTuEdit setTintColor:_COLOR_HEX(0x999999)];
        _yongTuEdit.delegate = self;
    }
    return _yongTuEdit;
}

- (UILabel *)zhouQiLabel {
    
    if (!_zhouQiLabel) {
        _zhouQiLabel = [[UILabel alloc] init];
        _zhouQiLabel.frame = CGRectMake(20.0f, self.yongTuEdit.frame.origin.y + self.yongTuEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _zhouQiLabel.font = [UIFont systemFontOfSize:13.0f];
        _zhouQiLabel.textColor = _COLOR_HEX(0x333333);
        _zhouQiLabel.textAlignment = NSTextAlignmentLeft;
        _zhouQiLabel.text = @"用款周期";
    }
    return _zhouQiLabel;
}

- (UITextField *)zhouQiEdit {
    
    if (!_zhouQiEdit) {
        _zhouQiEdit = [[UITextField alloc] init];
        _zhouQiEdit.frame = CGRectMake(20.0f, self.zhouQiLabel.frame.origin.y + self.zhouQiLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _zhouQiEdit.attributedPlaceholder = placeHolder;
        _zhouQiEdit.textAlignment = NSTextAlignmentCenter;
        _zhouQiEdit.backgroundColor = [UIColor whiteColor];
        _zhouQiEdit.layer.masksToBounds = YES;
        _zhouQiEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _zhouQiEdit.layer.borderWidth = 0.5f;
        _zhouQiEdit.layer.cornerRadius = 10.0f;
        [_zhouQiEdit setTintColor:_COLOR_HEX(0x999999)];
        _zhouQiEdit.delegate = self;
        
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
        clearButton.frame = _zhouQiEdit.bounds;
        clearButton.backgroundColor = [UIColor clearColor];
        [clearButton addTarget:self action:@selector(dropAction3:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.selected = NO;
        
        [_zhouQiEdit addSubview:dropButton];
        [_zhouQiEdit addSubview:clearButton];
    }
    return _zhouQiEdit;
}

- (SinglePickerView *)zhouQiPickerView {
    if (!_zhouQiPickerView) {
        _zhouQiPickerView = [[SinglePickerView alloc] initWithFrame:self.view.frame pickerViewType:PICKER_NORMAL];
        [_zhouQiPickerView.accessoryView.cancelBtn setHidden:YES];
        UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelectTableView)];
        [_zhouQiPickerView addGestureRecognizer:singleTap1];
        _zhouQiPickerView.dataList = @[@"一个月",@"三个月",@"六个月",@"九个月",@"十二个月"];
    }
    return _zhouQiPickerView;
}

- (void)dropAction3:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    [self.zhiZhaoEdit resignFirstResponder];
    [self.yongTuEdit resignFirstResponder];
    [self.qiXianEdit resignFirstResponder];
    [self.jinEEdit resignFirstResponder];
    [self.needTextView1 resignFirstResponder];
    [self.needTextView resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.zhouQiPickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [self.zhouQiPickerView show];
    }
    else {
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

- (UILabel *)qiXianLabel {
    
    if (!_qiXianLabel) {
        _qiXianLabel = [[UILabel alloc] init];
        _qiXianLabel.frame = CGRectMake(20.0f, self.zhouQiEdit.frame.origin.y + self.zhouQiEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _qiXianLabel.font = [UIFont systemFontOfSize:13.0f];
        _qiXianLabel.textColor = _COLOR_HEX(0x333333);
        _qiXianLabel.textAlignment = NSTextAlignmentLeft;
        _qiXianLabel.text = @"办理期限";
    }
    return _qiXianLabel;
}

- (UITextField *)qiXianEdit {
    
    if (!_qiXianEdit) {
        _qiXianEdit = [[UITextField alloc] init];
        _qiXianEdit.frame = CGRectMake(20.0f, self.qiXianLabel.frame.origin.y + self.qiXianLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
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

- (UILabel *)jinELabel {
    
    if (!_jinELabel) {
        _jinELabel = [[UILabel alloc] init];
        _jinELabel.frame = CGRectMake(20.0f, self.qiXianEdit.frame.origin.y + self.qiXianEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _jinELabel.font = [UIFont systemFontOfSize:13.0f];
        _jinELabel.textColor = _COLOR_HEX(0x333333);
        _jinELabel.textAlignment = NSTextAlignmentLeft;
        _jinELabel.text = @"贷款最高金额";
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

- (UILabel *)needLabel1 {
    
    if(!_needLabel1) {
        _needLabel1 = [[UILabel alloc] init];
        _needLabel1.frame = CGRectMake(20.0f, self.jinEEdit.frame.origin.y + self.jinEEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _needLabel1.font = [UIFont systemFontOfSize:13.0f];
        _needLabel1.textColor = _COLOR_HEX(0x333333);
        _needLabel1.textAlignment = NSTextAlignmentLeft;
        _needLabel1.text = @"抵押物说明";
    }
    return _needLabel1;
}

- (PlaceholderTextView *)needTextView1 {
    
    if (!_needTextView1) {
        _needTextView1 = [[PlaceholderTextView alloc] init];
        _needTextView1.frame = CGRectMake(20.0f, self.needLabel1.frame.origin.y + self.needLabel1.frame.size.height + 10.0f, MainWidth - 20.0f*2, 200.0f);
        _needTextView1.textAlignment = NSTextAlignmentCenter;
        _needTextView1.backgroundColor = [UIColor whiteColor];
        _needTextView1.scrollEnabled = NO;
        _needTextView1.editable = YES;
        _needTextView1.font = [UIFont systemFontOfSize:13.0f];
        _needTextView1.textColor = _COLOR_HEX(0x444444);
        _needTextView1.textAlignment = NSTextAlignmentLeft;
        _needTextView1.dataDetectorTypes = UIDataDetectorTypeAll;
        _needTextView1.layoutManager.allowsNonContiguousLayout = NO;
        _needTextView1.placeholderColor = _COLOR_HEX(0xcccccc);
        _needTextView1.backgroundColor = [UIColor whiteColor];
        _needTextView1.layer.masksToBounds = YES;
        _needTextView1.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _needTextView1.layer.borderWidth = 0.5f;
        _needTextView1.layer.cornerRadius = 10.0f;
        _needTextView1.delegate = self;
        [_needTextView1 addSubview:self.limitTipsLable1];
    }
    return _needTextView1;
}

- (UILabel *)limitTipsLable1 {
    if (!_limitTipsLable1) {
        _limitTipsLable1 = [[UILabel alloc] init];
        _limitTipsLable1.frame = CGRectMake(MainWidth - 20.0f*2.0f - 14.0f*2.0f - 100.0f, 200.0f - 15.0f - 19.0f, 100.0f, 19.0f);
        _limitTipsLable1.font = [UIFont systemFontOfSize:13.0f];
        _limitTipsLable1.textColor = _COLOR_HEX(0xcccccc);
        _limitTipsLable1.textAlignment = NSTextAlignmentRight;
        _limitTipsLable1.text = @"限2000字";
    }
    return _limitTipsLable1;
}


- (UILabel *)needLabel {
    
    if(!_needLabel) {
        _needLabel = [[UILabel alloc] init];
        _needLabel.frame = CGRectMake(20.0f, self.needTextView1.frame.origin.y + self.needTextView1.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
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
        _needTextView.delegate = self;
        [_needTextView addSubview:self.limitTipsLable];
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
        _commitButton.backgroundColor = [UIColor whiteColor];
        [_commitButton setTitle:@"我要贷款" forState:UIControlStateNormal];
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
        if ([pickerView isEqual:self.leiXingPickerView]) {
            self.leiXingEdit.text = selectedValue;
        }
        if ([pickerView isEqual:self.fuZhaiPickerView]) {
            self.fuZhaiEdit.text = selectedValue;
        }
        if ([pickerView isEqual:self.rongZiPickerView]) {
            self.rongZiEdit.text = selectedValue;
        }
        if ([pickerView isEqual:self.zhouQiPickerView]) {
            self.zhouQiEdit.text = selectedValue;
        }
    }
}

- (void)removeSelectTableView {
    [self.blackClearBackGroundButton removeFromSuperview];
    [_leiXingPickerView hide];
    [_fuZhaiPickerView hide];
    [_rongZiPickerView hide];
    [_zhouQiPickerView hide];
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
    if ([self.contactPersonEdit.text isEqualToString:@""] || [self.telphoneEdit.text isEqualToString:@""] || [self.enterpriseNameEdit.text isEqualToString:@""]|| [self.leiXingEdit.text isEqualToString:@""]|| [self.zhiZhaoEdit.text isEqualToString:@""]|| [self.fuZhaiEdit.text isEqualToString:@""]|| [self.rongZiEdit.text isEqualToString:@""]|| [self.yongTuEdit.text isEqualToString:@""]|| [self.zhouQiEdit.text isEqualToString:@""]|| [self.qiXianEdit.text isEqualToString:@""]|| [self.jinEEdit.text isEqualToString:@""]) {
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
                          @"cooperationType" : @"440",
                          @"contact" : contact,
                          @"contactNumber" : contactNumber,
                          @"enterpriseName" : self.enterpriseNameEdit.text,
                          @"subordinateIndustry" : self.leiXingEdit.text,
                          @"businessLicenseNo" : self.zhiZhaoEdit.text,
                          @"whetherLiabilities" : self.fuZhaiEdit.text,
                          @"financingType" : self.rongZiEdit.text,
                          @"fundUse":self.yongTuEdit.text,
                          @"paymentCycle":self.zhouQiEdit.text,
                          @"deadline":self.qiXianEdit.text,
                          @"maximumLoanAmount":self.jinEEdit.text,
                          @"collateralDescription":self.needTextView1.text,
                          @"remark":self.needTextView.text,
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
