//
//  ActivityCoorperationViewController.m
//  VSProject
//
//  Created by apple on 1/5/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "ActivityCoorperationViewController.h"
#import "PlaceholderTextView.h"
#import "BCNetWorkTool.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "MultiPickerView.h"
#import "SinglePickerView.h"

@interface ActivityCoorperationViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIView *appointmentView; // 存放所有控件

@property (nonatomic, strong) UILabel *contactPersonLabel; // 联系人
@property (nonatomic, strong) UITextField *contactPersonEdit; // 联系人输入

@property (nonatomic, strong) UILabel *telphoneLabel;  // 联系电话
@property (nonatomic, strong) UITextField *telphoneEdit; // 联系电话输出

@property (nonatomic, strong) UILabel *areaLabel; //所在区域
@property (nonatomic, strong) UITextField *areaEdit; // 所在区域输入
@property (nonatomic, strong) MultiPickerView *pickerView; //区域选择

@property (nonatomic, strong) UILabel *styleSelectLabel; // 方式选择
@property (nonatomic, strong) UITextField *styleSelectEdit; // 方式选择输入
@property (nonatomic, strong) SinglePickerView *singlePickerView;
@property (nonatomic, strong) UITableView *selectTableView; // 下拉列表

@property (nonatomic, strong) UILabel *needLabel; // 需求
@property (nonatomic, strong) PlaceholderTextView *needTextView; // 需求填写
@property (nonatomic, strong) UILabel *limitTipsLable;
@property (nonatomic, strong) UIButton *dropButton;  //弹出合作方式
@property (nonatomic, strong) UIButton *clearButton;  //弹出合作方式

@property (nonatomic, strong) UIButton *dropButton1;  //弹出所在区域
@property (nonatomic, strong) UIButton *clearButton1;  //弹出所在区域

@property (nonatomic, strong) UIButton *blackClearBackGroundButton;

@property (nonatomic, strong) UIButton *commitButton; // 提交按钮

@end

@implementation ActivityCoorperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self vs_setTitleText:@"活动合作信息填写"];
    
    self.view.backgroundColor = _COLOR_HEX(0xffffff);
    
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
        self.needTextView.text.length > 0 &&
        self.styleSelectEdit.text.length > 0) {
        
        if (self.telphoneEdit.text.length == 11 && [self.telphoneEdit.text hasPrefix:@"1"]) {
            [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.commitButton setEnabled:YES];
        }
    }
}

- (UIView *)appointmentView {
    
    if (!_appointmentView) {
        _appointmentView = [[UIView alloc] init];
        _appointmentView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f);
        
        [_appointmentView addSubview:self.contactPersonLabel];
        [_appointmentView addSubview:self.contactPersonEdit];
        [_appointmentView addSubview:self.telphoneLabel];
        [_appointmentView addSubview:self.telphoneEdit];
        [_appointmentView addSubview:self.areaLabel];
        [_appointmentView addSubview:self.areaEdit];
        [_appointmentView addSubview:self.styleSelectLabel];
        [_appointmentView addSubview:self.styleSelectEdit];
        [_appointmentView addSubview:self.needLabel];
        [_appointmentView addSubview:self.needTextView];
        [_appointmentView addSubview:self.commitButton];
        [_appointmentView addSubview:self.selectTableView];
        
        [_appointmentView setFrame:CGRectMake(0, 0, MainWidth, self.commitButton.frame.origin.y + self.commitButton.frame.size.height + 40)];
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
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _contactPersonEdit.attributedPlaceholder = placeHolder;
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
        [_telphoneEdit setKeyboardType:UIKeyboardTypeNumberPad];
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

- (UILabel *)areaLabel {
    
    if (!_areaLabel) {
        _areaLabel = [[UILabel alloc] init];
        _areaLabel.frame = CGRectMake(20.0f, self.telphoneEdit.frame.origin.y + self.telphoneEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
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
        self.dropButton1 = dropButton;
        
        UIButton *clearButton = [[UIButton alloc] init];
        clearButton.frame = _areaEdit.bounds;
        clearButton.backgroundColor = [UIColor clearColor];
        [clearButton addTarget:self action:@selector(dropAction1:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.selected = NO;
        self.clearButton1 = clearButton;
        
        [_areaEdit addSubview:dropButton];
        [_areaEdit addSubview:clearButton];
    }
    return _areaEdit;
}

- (MultiPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[MultiPickerView alloc] initWithFrame:self.view.frame];
        [_pickerView.accessoryView.cancelBtn setHidden:YES];
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelectTableView)];
        [_pickerView addGestureRecognizer:singleTap];
    }
    return _pickerView;
}

- (UILabel *)styleSelectLabel {
    
    if (!_styleSelectLabel) {
        _styleSelectLabel = [[UILabel alloc] init];
        _styleSelectLabel.frame = CGRectMake(20.0f, self.areaEdit.frame.origin.y + self.areaEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _styleSelectLabel.font = [UIFont systemFontOfSize:13.0f];
        _styleSelectLabel.textColor = _COLOR_HEX(0x333333);
        _styleSelectLabel.textAlignment = NSTextAlignmentLeft;
        _styleSelectLabel.text = @"活动合作方式选择";
    }
    return _styleSelectLabel;
}

- (UITextField *)styleSelectEdit {
    
    if (!_styleSelectEdit) {
        _styleSelectEdit = [[UITextField alloc] init];
        _styleSelectEdit.frame = CGRectMake(20.0f, self.styleSelectLabel.frame.origin.y + self.styleSelectLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _styleSelectEdit.attributedPlaceholder = placeHolder;
        _styleSelectEdit.textAlignment = NSTextAlignmentCenter;
        _styleSelectEdit.backgroundColor = [UIColor whiteColor];
        _styleSelectEdit.layer.masksToBounds = YES;
        _styleSelectEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _styleSelectEdit.layer.borderWidth = 0.5f;
        _styleSelectEdit.layer.cornerRadius = 8.0f;
        _styleSelectEdit.delegate = self;
        [_styleSelectEdit setTintColor:_COLOR_HEX(0x999999)];
        
        UIButton *dropButton = [[UIButton alloc] init];
        dropButton.frame = CGRectMake(MainWidth - 20.0f*2 - 28.0f, 0, 28.0f, 44.0f);
        dropButton.backgroundColor = [UIColor clearColor];
        [dropButton addTarget:self action:@selector(dropAction:) forControlEvents:UIControlEventTouchUpInside];
        dropButton.selected = NO;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, 28.0f, 44.0f);
        imageView.image = [UIImage imageNamed:@"list_drop_but"];
        [dropButton addSubview:imageView];
        self.dropButton = dropButton;
        
        UIButton *clearButton = [[UIButton alloc] init];
        clearButton.frame = _styleSelectEdit.bounds;
        clearButton.backgroundColor = [UIColor clearColor];
        [clearButton addTarget:self action:@selector(dropAction:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.selected = NO;
        self.clearButton = clearButton;
        
        [_styleSelectEdit addSubview:dropButton];
        [_styleSelectEdit addSubview:clearButton];
    }
    return _styleSelectEdit;
}

- (SinglePickerView *)singlePickerView {
    if (!_singlePickerView) {
        _singlePickerView = [[SinglePickerView alloc] initWithFrame:self.view.frame pickerViewType:PICKER_NORMAL];
        [_singlePickerView.accessoryView.cancelBtn setHidden:YES];
        UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelectTableView)];
        [_singlePickerView addGestureRecognizer:singleTap1];
        _singlePickerView.dataList = @[@"展销",@"发布会",@"招商",@"赞助"];;
    }
    return _singlePickerView;
}

- (UIButton *)blackClearBackGroundButton {
    if (!_blackClearBackGroundButton) {
        _blackClearBackGroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__)];
        [_blackClearBackGroundButton setBackgroundColor:ColorWithHex(0x000000, 0.6)];
        [_blackClearBackGroundButton addTarget:self action:@selector(removeSelectTableView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blackClearBackGroundButton;
}

- (UITableView *)selectTableView {
    
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] init];
        _selectTableView.frame = CGRectMake(0, __SCREEN_HEIGHT__ -(44.0f*5 + 10) -64, __SCREEN_WIDTH__, 44.0f*5 + 10);
        _selectTableView.backgroundColor = [UIColor whiteColor];
        _selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _selectTableView.layer.masksToBounds = YES;
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.hidden = YES;
        
        _selectTableView.estimatedRowHeight = 0;
        _selectTableView.estimatedSectionHeaderHeight = 0;
        _selectTableView.estimatedSectionFooterHeight = 0;
        
        [_selectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"selectCell"];
    }
    return _selectTableView;
}

- (UILabel *)needLabel {
    
    if(!_needLabel) {
        _needLabel = [[UILabel alloc] init];
        _needLabel.frame = CGRectMake(20.0f, self.styleSelectEdit.frame.origin.y + self.styleSelectEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
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
        _needTextView.layer.cornerRadius = 4.0f;
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
        [_commitButton setTitle:@"我要合作" forState:UIControlStateNormal];
        _commitButton.layer.cornerRadius = 10.0f;
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton setBackgroundColor:_COLOR_HEX(0x00c78c)];
        
        [_commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (void)commitAction:(UIButton *)button {
    if ([self.contactPersonEdit.text isEqualToString:@""] || [self.telphoneEdit.text isEqualToString:@""] || [self.styleSelectEdit.text isEqualToString:@""] || [self.areaEdit.text isEqualToString:@""]) {
//        PXAlertView *alertView = [PXAlertView showAlertWithTitle:@"提示" message:@"亲~你还有信息未填写哦~" cancelTitle:@"确定" otherTitle:nil completion:^(BOOL cancelled, NSInteger buttonIndex) {
//        }];
        
        [self.view showTipsView:@"亲~你还有信息未填写哦~"];
        
//        [alertView setBackgroundColor:[UIColor whiteColor]];
//        [alertView setTitleColor:[UIColor grayColor]];
//        [alertView setMessageColor:[UIColor grayColor]];
//        [alertView setCancelButtonTextColor:[UIColor grayColor]];
//        [alertView setOtherButtonTextColor:[UIColor grayColor]];
    }
    else {
        // 提交
        [self productSubscribe];
    }
}

- (void)dropAction:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.needTextView resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.singlePickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [self.singlePickerView show];
    }
    else {
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

- (void)dropAction1:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.needTextView resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
//        [self.appointmentView addSubview:self.blackClearBackGroundButton];
//        self.selectTableView.hidden = NO;
//        [self.appointmentView bringSubviewToFront:self.selectTableView];
        
        self.pickerView.delegate = (id<MultiPickerViewDelegate>)self;
        [self.pickerView show];
    }
    else {
        self.dropButton1.selected = NO;
        self.clearButton1.selected = NO;
        [self.blackClearBackGroundButton removeFromSuperview];
        self.selectTableView.hidden = YES;
    }
}

- (void)removeSelectTableView {
    self.dropButton.selected = NO;
    self.clearButton.selected = NO;
    
    self.dropButton1.selected = NO;
    self.clearButton1.selected = NO;
    
    [self.blackClearBackGroundButton removeFromSuperview];
    
    self.selectTableView.hidden = YES;
    [self.pickerView hide];
    [self.singlePickerView hide];
}

#pragma mark -- MultiPickerViewDelegate

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

#pragma mark - SinglePickerViewDelegate
- (void)SinglePickerView:(SinglePickerView *)pickerView selectedValue:(NSString *)selectedValue {
    if (selectedValue) {
        if ([pickerView isEqual:self.singlePickerView]) {
            self.styleSelectEdit.text = selectedValue;
        }
    }
}

#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *ItemLabel = [[UILabel alloc] init];
    ItemLabel.frame = CGRectMake(0, (44.0f - 14.0f)/2, tableView.frame.size.width, 14.0f);
    ItemLabel.font = [UIFont systemFontOfSize:13.0f];
    ItemLabel.textColor = _COLOR_HEX(0x333333);
    ItemLabel.textAlignment = NSTextAlignmentCenter;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                ItemLabel.text = @"展销";
                break;
            case 1:
                ItemLabel.text = @"发布会";
                break;
            case 2:
                ItemLabel.text = @"招商";
                break;
            case 3:
                ItemLabel.text = @"赞助";
                break;
                
            default:
                break;
        }
    } else {
        ItemLabel.text = @"取消";
    }
    
    [cell.contentView addSubview:ItemLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 43.5f, tableView.frame.size.width, 0.5f);
    lineView.backgroundColor = _COLOR_HEX(0xe5e5e5);
    [cell.contentView addSubview:lineView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0001f;
    } else {
        return 10.0001f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.dropButton.selected = NO;
    self.clearButton.selected = NO;
    [self.blackClearBackGroundButton removeFromSuperview];
    self.selectTableView.hidden = YES;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                self.styleSelectEdit.text = @"展销";
                break;
            case 1:
                self.styleSelectEdit.text = @"发布会";
                break;
            case 2:
                self.styleSelectEdit.text = @"招商";
                break;
            case 3:
                self.styleSelectEdit.text = @"赞助";
                break;
                
            default:
                break;
        }
    }
}

- (void)productSubscribe {
    
    dispatch_group_enter(requestGroup);
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *cooperationMode = @"1";
    if ([self.styleSelectEdit.text isEqualToString:@"展销"]) {
        cooperationMode = @"1";
    } else if ([self.styleSelectEdit.text isEqualToString:@"发布会"]) {
        cooperationMode = @"2";
    } else if ([self.styleSelectEdit.text isEqualToString:@"招商"]) {
        cooperationMode = @"3";
    }else if ([self.styleSelectEdit.text isEqualToString:@"赞助"]) {
        cooperationMode = @"4";
    }
    NSDictionary *dic = @{
                          @"partyId" : partyId,
                          @"cooperationType" : @"2",
                          @"contact" : self.contactPersonEdit.text,
                          @"contactNumber" : self.telphoneEdit.text,
                          @"locationArea" : self.areaEdit.text,
                          @"remark" : self.needTextView.text,
                          @"activityCooperationMode" : self.styleSelectEdit.text,
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
