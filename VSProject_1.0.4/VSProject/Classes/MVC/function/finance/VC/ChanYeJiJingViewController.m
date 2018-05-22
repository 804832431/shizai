//
//  ChanYeJiJingViewController.m
//  VSProject
//
//  Created by apple on 3/19/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "ChanYeJiJingViewController.h"
#import "PlaceholderTextView.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "BCNetWorkTool.h"
#import "SinglePickerView.h"
#import "MultiPickerView.h"

@interface ChanYeJiJingViewController ()
<UITextFieldDelegate, UITextViewDelegate>
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

@property (nonatomic, strong) UILabel *areaLabel; //所在区域
@property (nonatomic, strong) UITextField *areaEdit; // 所在区域输入
@property (nonatomic, strong) MultiPickerView *areaPickerView; //区域选择

@property (nonatomic, strong) UILabel *guiMoLabel;  // 企业规模
@property (nonatomic, strong) UITextField *guiMoEdit; // 企业阶段输出
@property (nonatomic, strong) SinglePickerView *guiMoPickerView;

@property (nonatomic, strong) UILabel *hangYeLabel;  //行业类型
@property (nonatomic, strong) UITextField *hangYeEdit;

@property (nonatomic, strong) UILabel *rongZiLabel;  // 目前融资情况
@property (nonatomic, strong) UITextField *rongZiEdit;
@property (nonatomic, strong) SinglePickerView *rongZiPickerView;

@property (nonatomic, strong) UILabel *needLabel; // 补充说明
@property (nonatomic, strong) PlaceholderTextView *needTextView; // 需求填写
@property (nonatomic, strong) UILabel *limitTipsLable;

@property (nonatomic, strong) UIButton *commitButton; // 提交按钮@end

@property (nonatomic, strong) UIButton *blackClearBackGroundButton;
@end

@implementation ChanYeJiJingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"产业基金信息填写"];
    
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
        
        [_appointmentView addSubview:self.areaLabel];
        [_appointmentView addSubview:self.areaEdit];
        
        [_appointmentView addSubview:self.guiMoLabel];
        [_appointmentView addSubview:self.guiMoEdit];
        
        [_appointmentView addSubview:self.hangYeLabel];
        [_appointmentView addSubview:self.hangYeEdit];
        
        [_appointmentView addSubview:self.rongZiLabel];
        [_appointmentView addSubview:self.rongZiEdit];
        
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

- (UILabel *)areaLabel {
    
    if (!_areaLabel) {
        _areaLabel = [[UILabel alloc] init];
        _areaLabel.frame = CGRectMake(20.0f, self.enterpriseNameEdit.frame.origin.y + self.enterpriseNameEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _areaLabel.font = [UIFont systemFontOfSize:13.0f];
        _areaLabel.textColor = _COLOR_HEX(0x333333);
        _areaLabel.textAlignment = NSTextAlignmentLeft;
        _areaLabel.text = @"所在区域";
    }
    return _areaLabel;
}

- (UITextField *)areaEdit {
    
    if (!_areaEdit) {
        _areaEdit = [[UITextField alloc] init];
        _areaEdit.frame = CGRectMake(20.0f, self.areaLabel.frame.origin.y + self.areaLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _areaEdit.attributedPlaceholder = placeHolder;
        _areaEdit.textAlignment = NSTextAlignmentCenter;
        _areaEdit.backgroundColor = [UIColor whiteColor];
        _areaEdit.layer.masksToBounds = YES;
        _areaEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _areaEdit.layer.borderWidth = 0.5f;
        _areaEdit.layer.cornerRadius = 8.0f;
        _areaEdit.delegate = self;
        [_areaEdit setTintColor:_COLOR_HEX(0x999999)];
        
        UIButton *dropButton = [[UIButton alloc] init];
        dropButton.frame = CGRectMake(MainWidth - 20.0f*2 - 28.0f, 0, 28.0f, 44.0f);
        dropButton.backgroundColor = [UIColor clearColor];
        [dropButton addTarget:self action:@selector(dropAction1:) forControlEvents:UIControlEventTouchUpInside];
        dropButton.selected = NO;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, 28.0f, 44.0f);
        imageView.image = [UIImage imageNamed:@"list_drop_but"];
        [dropButton addSubview:imageView];
        
        UIButton *clearButton = [[UIButton alloc] init];
        clearButton.frame = _areaEdit.bounds;
        clearButton.backgroundColor = [UIColor clearColor];
        [clearButton addTarget:self action:@selector(dropAction1:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.selected = NO;
        
        [_areaEdit addSubview:dropButton];
        [_areaEdit addSubview:clearButton];
    }
    return _areaEdit;
}

- (MultiPickerView *)areaPickerView {
    if (!_areaPickerView) {
        _areaPickerView = [[MultiPickerView alloc] initWithFrame:self.view.frame];
        [_areaPickerView.accessoryView.cancelBtn setHidden:YES];
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelectTableView)];
        [_areaPickerView addGestureRecognizer:singleTap];
    }
    return _areaPickerView;
}

- (UILabel *)guiMoLabel {
    
    if (!_guiMoLabel) {
        _guiMoLabel = [[UILabel alloc] init];
        _guiMoLabel.frame = CGRectMake(20.0f, self.areaEdit.frame.origin.y + self.areaEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
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


- (UILabel *)rongZiLabel {
    
    if (!_rongZiLabel) {
        _rongZiLabel = [[UILabel alloc] init];
        _rongZiLabel.frame = CGRectMake(20.0f, self.hangYeEdit.frame.origin.y + self.hangYeEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _rongZiLabel.font = [UIFont systemFontOfSize:13.0f];
        _rongZiLabel.textColor = _COLOR_HEX(0x333333);
        _rongZiLabel.textAlignment = NSTextAlignmentLeft;
        _rongZiLabel.text = @"目前融资情况";
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
        [clearButton addTarget:self action:@selector(dropActionRongzi:) forControlEvents:UIControlEventTouchUpInside];
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
        _rongZiPickerView.dataList = @[@"初创",@"天使",@"A轮",@"已上市"];;
    }
    return _rongZiPickerView;
}

- (void)dropActionRongzi:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    [self.hangYeEdit resignFirstResponder];
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

- (UILabel *)needLabel {
    
    if(!_needLabel) {
        _needLabel = [[UILabel alloc] init];
        _needLabel.frame = CGRectMake(20.0f, self.rongZiEdit.frame.origin.y + self.rongZiEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
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
        [_commitButton setTitle:@"我要申请基金" forState:UIControlStateNormal];
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
        if ([pickerView isEqual:self.rongZiPickerView]) {
            self.rongZiEdit.text = selectedValue;
        }
    }
}

- (void)removeSelectTableView {
    [self.blackClearBackGroundButton removeFromSuperview];
    [_areaPickerView hide];
    [_guiMoPickerView hide];
    [_rongZiPickerView hide];
}

- (UIButton *)blackClearBackGroundButton {
    if (!_blackClearBackGroundButton) {
        _blackClearBackGroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__)];
        [_blackClearBackGroundButton setBackgroundColor:ColorWithHex(0x000000, 0.6)];
        [_blackClearBackGroundButton addTarget:self action:@selector(removeSelectTableView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blackClearBackGroundButton;
}

#pragma mark -- MultiPickerViewDelegate

- (void)dropAction1:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    [self.hangYeEdit resignFirstResponder];
    [self.needTextView resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.areaPickerView.delegate = (id<MultiPickerViewDelegate>)self;
        [self.areaPickerView show];
    }
    else {
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

- (void)MultiPickerView:(MultiPickerView *)pickerView leftValue:(NSString *)leftValue middleValue:(NSString *)middleValue rightValue:(NSString *)rightValue {
    
    if (leftValue && middleValue && rightValue) {
        if ([middleValue isEqualToString:@"市辖区"]||[middleValue isEqualToString:@"县"]) {
            _areaEdit.text = [NSString stringWithFormat:@"%@%@",leftValue,rightValue];
        }else {
            _areaEdit.text = [NSString stringWithFormat:@"%@%@%@",leftValue,middleValue,rightValue];
        }
    }else {
        [self.view showTipsView:@"请选择地区"];
    }
}

//请求省市区
- (void)MultiPickerView:(MultiPickerView *)pickerView requestLocations:(NSString *)type dataId:(NSString *)dataId{
    
    NSDictionary *paraDic = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",dataId,@"dataId", nil];
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.postaladdress/get-locations-data"];
    [self vs_showLoading];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        if ([type isEqualToString:@"province"]) {
            
            pickerView.leftArray = [NSArray arrayWithArray:[responseObj objectForKey:@"provinces"]];
            [pickerView.pickerView reloadComponent:0];
            [pickerView pickerView:pickerView.pickerView didSelectRow:0 inComponent:0];
            
        }else if ([type isEqualToString:@"city"]) {
            
            pickerView.middleArray = [NSArray arrayWithArray:[responseObj objectForKey:@"cities"]];
            [pickerView.pickerView reloadComponent:1];
            [pickerView pickerView:pickerView.pickerView didSelectRow:0 inComponent:1];
            
        }else if ([type isEqualToString:@"area"]) {
            
            pickerView.rightArray = [NSArray arrayWithArray:[responseObj objectForKey:@"areas"]];
            [pickerView.pickerView reloadComponent:2];
            [pickerView pickerView:pickerView.pickerView didSelectRow:0 inComponent:3];
        }
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}

#pragma mark - Commit action
- (void)commitAction:(UIButton *)button {
    if ([self.contactPersonEdit.text isEqualToString:@""] || [self.telphoneEdit.text isEqualToString:@""] || [self.enterpriseNameEdit.text isEqualToString:@""]|| [self.hangYeEdit.text isEqualToString:@""]|| [self.areaEdit.text isEqualToString:@""]|| [self.guiMoEdit.text isEqualToString:@""] || [self.rongZiEdit.text isEqualToString:@""]) {
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
                          @"cooperationType" : @"43",
                          @"contact" : contact,
                          @"contactNumber" : contactNumber,
                          @"enterpriseName" : self.enterpriseNameEdit.text,
                          @"locationArea" : self.areaEdit.text,
                          @"enterpriseScale" : self.guiMoEdit.text,
                          @"subordinateIndustry" : self.hangYeEdit.text,
                          @"currentFinancing" : self.rongZiEdit.text,
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
