//
//  ShangShiFuWuViewController.m
//  VSProject
//
//  Created by apple on 3/19/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "ShangShiFuWuViewController.h"
#import "PlaceholderTextView.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "BCNetWorkTool.h"
#import "SinglePickerView.h"
#import "MultiPickerView.h"

@interface ShangShiFuWuViewController () <UITextFieldDelegate, UITextViewDelegate>
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

@property (nonatomic, strong) UILabel *guiMoLabel;  // 企业规模
@property (nonatomic, strong) UITextField *guiMoEdit;
@property (nonatomic, strong) SinglePickerView *guiMoPickerView;

@property (nonatomic, strong) UILabel *hangYeLabel;  // 行业类型
@property (nonatomic, strong) UITextField *hangYeEdit;

@property (nonatomic, strong) UILabel *guQuanLabel;  //股权结构
@property (nonatomic, strong) UITextField *guQuanEdit;

@property (nonatomic, strong) UILabel *shouRuLabel;  //上一年营业收入
@property (nonatomic, strong) UITextField *shouRuEdit;

@property (nonatomic, strong) UILabel *liRunLabel;  //上一年净利润
@property (nonatomic, strong) UITextField *liRunEdit;

@property (nonatomic, strong) UILabel *needLabel; // 补充说明
@property (nonatomic, strong) PlaceholderTextView *needTextView;
@property (nonatomic, strong) UILabel *limitTipsLable;

@property (nonatomic, strong) UIButton *commitButton; // 提交按钮@end

@property (nonatomic, strong) UIButton *blackClearBackGroundButton;
@end

@implementation ShangShiFuWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"上市服务信息填写"];
    
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
        
        [_appointmentView addSubview:self.guiMoLabel];
        [_appointmentView addSubview:self.guiMoEdit];
        
        [_appointmentView addSubview:self.hangYeLabel];
        [_appointmentView addSubview:self.hangYeEdit];
        
        [_appointmentView addSubview:self.guQuanLabel];
        [_appointmentView addSubview:self.guQuanEdit];
        
        [_appointmentView addSubview:self.shouRuLabel];
        [_appointmentView addSubview:self.shouRuEdit];
        
        [_appointmentView addSubview:self.liRunLabel];
        [_appointmentView addSubview:self.liRunEdit];
        
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

- (UILabel *)guiMoLabel {
    
    if (!_guiMoLabel) {
        _guiMoLabel = [[UILabel alloc] init];
        _guiMoLabel.frame = CGRectMake(20.0f, self.enterpriseNameEdit.frame.origin.y + self.enterpriseNameEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _guiMoLabel.font = [UIFont systemFontOfSize:13.0f];
        _guiMoLabel.textColor = _COLOR_HEX(0x333333);
        _guiMoLabel.textAlignment = NSTextAlignmentLeft;
        _guiMoLabel.text = @"企业规模";
    }
    return _guiMoLabel;
}

- (UITextField *)guiMoEdit {
    
    if (!_guiMoEdit) {
        _guiMoEdit = [[UITextField alloc] init];
        _guiMoEdit.frame = CGRectMake(20.0f, self.guiMoLabel.frame.origin.y + self.guiMoLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _guiMoEdit.attributedPlaceholder = placeHolder;
        _guiMoEdit.textAlignment = NSTextAlignmentCenter;
        _guiMoEdit.backgroundColor = [UIColor whiteColor];
        _guiMoEdit.layer.masksToBounds = YES;
        _guiMoEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _guiMoEdit.layer.borderWidth = 0.5f;
        _guiMoEdit.layer.cornerRadius = 10.0f;
        [_guiMoEdit setTintColor:_COLOR_HEX(0x999999)];
        _guiMoEdit.delegate = self;
        
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
        clearButton.frame = _guiMoEdit.bounds;
        clearButton.backgroundColor = [UIColor clearColor];
        [clearButton addTarget:self action:@selector(dropAction:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.selected = NO;
        
        [_guiMoEdit addSubview:dropButton];
        [_guiMoEdit addSubview:clearButton];
    }
    return _guiMoEdit;
}

- (SinglePickerView *)guiMoPickerView {
    if (!_guiMoPickerView) {
        _guiMoPickerView = [[SinglePickerView alloc] initWithFrame:self.view.frame pickerViewType:PICKER_NORMAL];
        [_guiMoPickerView.accessoryView.cancelBtn setHidden:YES];
        UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelectTableView)];
        [_guiMoPickerView addGestureRecognizer:singleTap1];
        _guiMoPickerView.dataList = @[@"少于50人",@"50-150人",@"150-500人",@"500-1000人",@"1000-5000人",@"5000-10000人",@"10000人以上"];;
    }
    return _guiMoPickerView;
}

- (void)dropAction:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    [self.hangYeEdit resignFirstResponder];
    [self.needTextView resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.guiMoPickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [self.guiMoPickerView show];
    }
    else {
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

- (UILabel *)hangYeLabel {
    
    if (!_hangYeLabel) {
        _hangYeLabel = [[UILabel alloc] init];
        _hangYeLabel.frame = CGRectMake(20.0f, self.guiMoEdit.frame.origin.y + self.guiMoEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _hangYeLabel.font = [UIFont systemFontOfSize:13.0f];
        _hangYeLabel.textColor = _COLOR_HEX(0x333333);
        _hangYeLabel.textAlignment = NSTextAlignmentLeft;
        _hangYeLabel.text = @"行业类型";
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

- (UILabel *)guQuanLabel {
    
    if (!_guQuanLabel) {
        _guQuanLabel = [[UILabel alloc] init];
        _guQuanLabel.frame = CGRectMake(20.0f, self.hangYeEdit.frame.origin.y + self.hangYeEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _guQuanLabel.font = [UIFont systemFontOfSize:13.0f];
        _guQuanLabel.textColor = _COLOR_HEX(0x333333);
        _guQuanLabel.textAlignment = NSTextAlignmentLeft;
        _guQuanLabel.text = @"股权结构";
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
        [_guQuanEdit setKeyboardType:UIKeyboardTypeNumberPad];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_guQuanEdit.frame.size.width - 25, 0, 25, _guQuanEdit.frame.size.height)];
        [label setTextColor:[UIColor blackColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setText:@"人"];
        [_guQuanEdit addSubview:label];
        
    }
    return _guQuanEdit;
}

- (UILabel *)shouRuLabel {
    
    if (!_shouRuLabel) {
        _shouRuLabel = [[UILabel alloc] init];
        _shouRuLabel.frame = CGRectMake(20.0f, self.guQuanEdit.frame.origin.y + self.guQuanEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _shouRuLabel.font = [UIFont systemFontOfSize:13.0f];
        _shouRuLabel.textColor = _COLOR_HEX(0x333333);
        _shouRuLabel.textAlignment = NSTextAlignmentLeft;
        _shouRuLabel.text = @"上一年营业收入";
    }
    return _shouRuLabel;
}

- (UITextField *)shouRuEdit {
    
    if (!_shouRuEdit) {
        _shouRuEdit = [[UITextField alloc] init];
        _shouRuEdit.frame = CGRectMake(20.0f, self.shouRuLabel.frame.origin.y + self.shouRuLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _shouRuEdit.attributedPlaceholder = placeHolder;
        _shouRuEdit.textAlignment = NSTextAlignmentCenter;
        _shouRuEdit.backgroundColor = [UIColor whiteColor];
        _shouRuEdit.layer.masksToBounds = YES;
        _shouRuEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _shouRuEdit.layer.borderWidth = 0.5f;
        _shouRuEdit.layer.cornerRadius = 10.0f;
        [_shouRuEdit setTintColor:_COLOR_HEX(0x999999)];
        _shouRuEdit.delegate = self;
        [_shouRuEdit setKeyboardType:UIKeyboardTypeDecimalPad];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_shouRuEdit.frame.size.width - 40, 0, 40, _shouRuEdit.frame.size.height)];
        [label setTextColor:[UIColor blackColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setText:@"万元"];
        [_shouRuEdit addSubview:label];
        
    }
    return _shouRuEdit;
}


- (UILabel *)liRunLabel {
    
    if (!_liRunLabel) {
        _liRunLabel = [[UILabel alloc] init];
        _liRunLabel.frame = CGRectMake(20.0f, self.shouRuEdit.frame.origin.y + self.shouRuEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _liRunLabel.font = [UIFont systemFontOfSize:13.0f];
        _liRunLabel.textColor = _COLOR_HEX(0x333333);
        _liRunLabel.textAlignment = NSTextAlignmentLeft;
        _liRunLabel.text = @"上一年净利润";
    }
    return _liRunLabel;
}

- (UITextField *)liRunEdit {
    
    if (!_liRunEdit) {
        _liRunEdit = [[UITextField alloc] init];
        _liRunEdit.frame = CGRectMake(20.0f, self.liRunLabel.frame.origin.y + self.liRunLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _liRunEdit.attributedPlaceholder = placeHolder;
        _liRunEdit.textAlignment = NSTextAlignmentCenter;
        _liRunEdit.backgroundColor = [UIColor whiteColor];
        _liRunEdit.layer.masksToBounds = YES;
        _liRunEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _liRunEdit.layer.borderWidth = 0.5f;
        _liRunEdit.layer.cornerRadius = 10.0f;
        [_liRunEdit setTintColor:_COLOR_HEX(0x999999)];
        _liRunEdit.delegate = self;
        [_liRunEdit setKeyboardType:UIKeyboardTypeDecimalPad];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_liRunEdit.frame.size.width - 40, 0, 40, _liRunEdit.frame.size.height)];
        [label setTextColor:[UIColor blackColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setText:@"万元"];
        [_liRunEdit addSubview:label];
        
    }
    return _liRunEdit;
}

- (UILabel *)needLabel {
    
    if(!_needLabel) {
        _needLabel = [[UILabel alloc] init];
        _needLabel.frame = CGRectMake(20.0f, self.liRunEdit.frame.origin.y + self.liRunEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
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
        [_commitButton setTitle:@"我要上市" forState:UIControlStateNormal];
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
        if ([pickerView isEqual:self.guiMoPickerView]) {
            self.guiMoEdit.text = selectedValue;
        }
    }
}

- (void)removeSelectTableView {
    [self.blackClearBackGroundButton removeFromSuperview];
    [_guiMoPickerView hide];
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
    if ([self.contactPersonEdit.text isEqualToString:@""] || [self.telphoneEdit.text isEqualToString:@""] || [self.enterpriseNameEdit.text isEqualToString:@""]|| [self.hangYeEdit.text isEqualToString:@""]|| [self.guiMoEdit.text isEqualToString:@""]|| [self.guQuanEdit.text isEqualToString:@""]|| [self.shouRuEdit.text isEqualToString:@""]|| [self.liRunEdit.text isEqualToString:@""]) {
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
                          @"cooperationType" : @"42",
                          @"contact" : contact,
                          @"contactNumber" : contactNumber,
                          @"enterpriseName" : self.enterpriseNameEdit.text,
                          @"enterpriseScale" : self.guiMoEdit.text,
                          @"subordinateIndustry" : self.hangYeEdit.text,
                          @"ownershipStructure" : self.guQuanEdit.text,
                          @"lastYearIncome" : self.shouRuEdit.text,
                          @"lastYearNetProfit":self.liRunEdit.text,
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
