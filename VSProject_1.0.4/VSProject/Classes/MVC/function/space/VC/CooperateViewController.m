//
//  CooperateViewController.m
//  VSProject
//
//  Created by pch_tiger on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import "CooperateViewController.h"
#import "PlaceholderTextView.h"
#import "BCNetWorkTool.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "MultiPickerView.h"
#import "SinglePickerView.h"
#import "SelectPhotoViewController.h"
#import "CenterManger.h"

@interface CooperateViewController () <UITextFieldDelegate,UITextViewDelegate>
{
    dispatch_group_t requestGroup;
    CenterManger *manger;
}

@property (nonatomic, strong) UIView *appointmentView; // 存放所有控件

@property (nonatomic, strong) UILabel *contactPersonLabel; // 联系人
@property (nonatomic, strong) UITextField *contactPersonEdit; // 联系人输入

@property (nonatomic, strong) UILabel *telphoneLabel;  // 联系电话
@property (nonatomic, strong) UITextField *telphoneEdit; // 联系电话输出

@property (nonatomic, strong) UILabel *enterpriseNameLabel;  // 企业名称
@property (nonatomic, strong) UITextField *enterpriseNameEdit; // 企业名称输出

@property (nonatomic, strong) UILabel *areaLabel; //所在区域
@property (nonatomic, strong) UITextField *areaEdit; // 所在区域输入
@property (nonatomic, strong) MultiPickerView *pickerView; //区域选择

@property (nonatomic, strong) UILabel *styleSelectLabel; // 方式选择
@property (nonatomic, strong) UITextField *styleSelectEdit; // 方式选择输入
@property (nonatomic, strong) SinglePickerView *singlePickerView; //合作意向

@property (nonatomic, strong) UILabel *mianJiLabel;  // 面积
@property (nonatomic, strong) UITextField *mianJiEdit; // 面积输出

@property (nonatomic, strong) UILabel *photoLabel;  // 空间照片
@property (nonatomic, strong) UIButton *photoEdit; // 面积输出
@property (nonatomic, strong) NSString *photoPath;  //返回的图片路径

@property (nonatomic, strong) UILabel *yongTuLabel; // 使用用途
@property (nonatomic, strong) UITextField *yongTuEdit; // 使用用途输入
@property (nonatomic, strong) SinglePickerView *yongTuPickerView; //使用用途

@property (nonatomic, strong) UILabel *needLabel; // 需求
@property (nonatomic, strong) PlaceholderTextView *needTextView; // 需求填写
@property (nonatomic, strong) UILabel *limitTipsLable;
@property (nonatomic, strong) UIButton *dropButton;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UIButton *blackClearBackGroundButton;

@property (nonatomic, strong) UIButton *commitButton; // 提交按钮

@end

@implementation CooperateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"空间合作信息填写"];
    
    self.view.backgroundColor = _COLOR_HEX(0xffffff);
    
    requestGroup = dispatch_group_create();
    
    manger = [[CenterManger alloc]init];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - 64.0f)];
    [scrollView setContentSize:self.appointmentView.frame.size];
    [scrollView addSubview:self.appointmentView];
    
    [self.view addSubview:scrollView];
    
    self.photoPath = @"";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeSelectTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)vs_leftButtonActon {
    
    [super vs_leftButtonActon];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"COOPERATE_GOBACK" object:nil];
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
        
        [_appointmentView addSubview:self.enterpriseNameLabel];
        [_appointmentView addSubview:self.enterpriseNameEdit];
        
        [_appointmentView addSubview:self.areaLabel];
        [_appointmentView addSubview:self.areaEdit];
        
        [_appointmentView addSubview:self.styleSelectLabel];
        [_appointmentView addSubview:self.styleSelectEdit];
        
        [_appointmentView addSubview:self.mianJiLabel];
        [_appointmentView addSubview:self.mianJiEdit];
        
        [_appointmentView addSubview:self.photoLabel];
        [_appointmentView addSubview:self.photoEdit];
        
        [_appointmentView addSubview:self.yongTuLabel];
        [_appointmentView addSubview:self.yongTuEdit];
        
        [_appointmentView addSubview:self.needLabel];
        [_appointmentView addSubview:self.needTextView];
        [_appointmentView addSubview:self.commitButton];
        
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
        _contactPersonEdit.layer.cornerRadius = 10.0f;
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
        _telphoneEdit.layer.cornerRadius = 10.0f;
        _telphoneEdit.delegate = self;
        [_telphoneEdit setTintColor:_COLOR_HEX(0x999999)];
        [_telphoneEdit setKeyboardType:UIKeyboardTypeNumberPad];
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
        _enterpriseNameEdit.delegate = self;
        [_enterpriseNameEdit setTintColor:_COLOR_HEX(0x999999)];
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
        _styleSelectLabel.text = @"合作意向";
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
        _singlePickerView.dataList = @[@"出租",@"购置"];;
    }
    return _singlePickerView;
}

- (UILabel *)mianJiLabel {
    
    if (!_mianJiLabel) {
        _mianJiLabel = [[UILabel alloc] init];
        _mianJiLabel.frame = CGRectMake(20.0f, self.styleSelectEdit.frame.origin.y + self.styleSelectEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _mianJiLabel.font = [UIFont systemFontOfSize:13.0f];
        _mianJiLabel.textColor = _COLOR_HEX(0x333333);
        _mianJiLabel.textAlignment = NSTextAlignmentLeft;
        _mianJiLabel.text = @"面积";
    }
    return _mianJiLabel;
}

- (UITextField *)mianJiEdit {
    
    if (!_mianJiEdit) {
        _mianJiEdit = [[UITextField alloc] init];
        _mianJiEdit.frame = CGRectMake(20.0f, self.mianJiLabel.frame.origin.y + self.mianJiLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, 44.0f);
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"(必填)"];
        [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, placeHolder.length)];
        [placeHolder addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x999999) range:NSMakeRange(0, placeHolder.length)];
        _mianJiEdit.attributedPlaceholder = placeHolder;
        _mianJiEdit.textAlignment = NSTextAlignmentCenter;
        _mianJiEdit.backgroundColor = [UIColor whiteColor];
        _mianJiEdit.layer.masksToBounds = YES;
        _mianJiEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _mianJiEdit.layer.borderWidth = 0.5f;
        _mianJiEdit.layer.cornerRadius = 10.0f;
        _mianJiEdit.delegate = self;
        [_mianJiEdit setTintColor:_COLOR_HEX(0x999999)];
        [_mianJiEdit setKeyboardType:UIKeyboardTypeNumberPad];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_mianJiEdit.frame.size.width - 25, 0, 25, _mianJiEdit.frame.size.height)];
        [label setTextColor:[UIColor blackColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setText:@"㎡"];
        [_mianJiEdit addSubview:label];
    }
    return _mianJiEdit;
}

- (UILabel *)photoLabel {
    
    if (!_photoLabel) {
        _photoLabel = [[UILabel alloc] init];
        _photoLabel.frame = CGRectMake(20.0f, self.mianJiEdit.frame.origin.y + self.mianJiEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _photoLabel.font = [UIFont systemFontOfSize:13.0f];
        _photoLabel.textColor = _COLOR_HEX(0x333333);
        _photoLabel.textAlignment = NSTextAlignmentLeft;
        _photoLabel.text = @"空间照片";
    }
    return _photoLabel;
}

- (UIButton *)photoEdit {
    
    if (!_photoEdit) {
        _photoEdit = [[UIButton alloc] init];
        _photoEdit.frame = CGRectMake(20.0f, self.photoLabel.frame.origin.y + self.photoLabel.frame.size.height + 10.0f, MainWidth - 20.0f*2, (MainWidth - 20.0f*2)*320/704);
        _photoEdit.backgroundColor = [UIColor whiteColor];
        _photoEdit.layer.masksToBounds = YES;
        _photoEdit.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _photoEdit.layer.borderWidth = 0.5f;
        _photoEdit.layer.cornerRadius = 10.0f;
        [_photoEdit setTintColor:_COLOR_HEX(0x999999)];
        [_photoEdit addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoEdit;
}

- (IBAction)choosePhoto:(id)sender {
    SelectPhotoViewController *controller = [[SelectPhotoViewController alloc]init];
    controller.cutSize = CGSizeMake(MainWidth, MainWidth * 320 / 740);
    controller.getPhotosBlock = ^(UIImage *image) {
        
        [self updateSpacePhoto:image];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)updateSpacePhoto:(UIImage *)image {
    
    [self vs_showLoading];
    __weak __typeof(&*self)weakSelf = self;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSArray *array = [NSArray arrayWithObject:imageData];
    [manger updateSpaceIcon:nil dataArray:array success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        if (responseObj) {
            weakSelf.photoPath = [(NSDictionary *)responseObj valueForKey:@"path"];
            [weakSelf.photoEdit setImage:image forState:UIControlStateNormal];
            [weakSelf.photoEdit setImage:image forState:UIControlStateHighlighted];
        }else {
            [self.view showTipsView:@"请求失败"];
        }
    } failure:^(NSError *error) {
        //
        [self.view showTipsView:[error domain]];
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

- (UILabel *)yongTuLabel {
    
    if (!_yongTuLabel) {
        _yongTuLabel = [[UILabel alloc] init];
        _yongTuLabel.frame = CGRectMake(20.0f, self.photoEdit.frame.origin.y + self.photoEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
        _yongTuLabel.font = [UIFont systemFontOfSize:13.0f];
        _yongTuLabel.textColor = _COLOR_HEX(0x333333);
        _yongTuLabel.textAlignment = NSTextAlignmentLeft;
        _yongTuLabel.text = @"使用用途";
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
        _yongTuEdit.layer.cornerRadius = 8.0f;
        _yongTuEdit.delegate = self;
        [_yongTuEdit setTintColor:_COLOR_HEX(0x999999)];
        
        UIButton *dropButton = [[UIButton alloc] init];
        dropButton.frame = CGRectMake(MainWidth - 20.0f*2 - 28.0f, 0, 28.0f, 44.0f);
        dropButton.backgroundColor = [UIColor clearColor];
        [dropButton addTarget:self action:@selector(dropAction2:) forControlEvents:UIControlEventTouchUpInside];
        dropButton.selected = NO;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, 28.0f, 44.0f);
        imageView.image = [UIImage imageNamed:@"list_drop_but"];
        [dropButton addSubview:imageView];
        
        UIButton *clearButton = [[UIButton alloc] init];
        clearButton.frame = _styleSelectEdit.bounds;
        clearButton.backgroundColor = [UIColor clearColor];
        [clearButton addTarget:self action:@selector(dropAction2:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.selected = NO;
        
        [_yongTuEdit addSubview:dropButton];
        [_yongTuEdit addSubview:clearButton];
    }
    return _yongTuEdit;
}

- (SinglePickerView *)yongTuPickerView {
    if (!_yongTuPickerView) {
        _yongTuPickerView = [[SinglePickerView alloc] initWithFrame:self.view.frame pickerViewType:PICKER_NORMAL];
        [_yongTuPickerView.accessoryView.cancelBtn setHidden:YES];
        UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelectTableView)];
        [_yongTuPickerView addGestureRecognizer:singleTap1];
        _yongTuPickerView.dataList = @[@"住宅",@"办公",@"商业"];;
    }
    return _yongTuPickerView;
}

#pragma mark - method

- (UIButton *)blackClearBackGroundButton {
    if (!_blackClearBackGroundButton) {
        _blackClearBackGroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__)];
        [_blackClearBackGroundButton setBackgroundColor:ColorWithHex(0x000000, 0.6)];
        [_blackClearBackGroundButton addTarget:self action:@selector(removeSelectTableView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blackClearBackGroundButton;
}

- (void)dropAction:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.needTextView resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    [self.mianJiEdit resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.singlePickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [self.singlePickerView show];
    }
    else {
        self.dropButton.selected = NO;
        self.clearButton.selected = NO;
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

- (void)dropAction2:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.needTextView resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    [self.mianJiEdit resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.yongTuPickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [self.yongTuPickerView show];
    }
    else {
        self.dropButton.selected = NO;
        self.clearButton.selected = NO;
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

#pragma mark - SinglePickerViewDelegate
- (void)SinglePickerView:(SinglePickerView *)pickerView selectedValue:(NSString *)selectedValue {
    if (selectedValue) {
        if ([pickerView isEqual:self.singlePickerView]) {
            self.styleSelectEdit.text = selectedValue;
        } else if ([pickerView isEqual:self.yongTuPickerView]) {
            self.yongTuEdit.text = selectedValue;
        }
    }
}

- (void)dropAction1:(UIButton *)button {
    [self.contactPersonEdit resignFirstResponder];
    [self.telphoneEdit resignFirstResponder];
    [self.needTextView resignFirstResponder];
    [self.enterpriseNameEdit resignFirstResponder];
    [self.mianJiEdit resignFirstResponder];
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        self.pickerView.delegate = (id<MultiPickerViewDelegate>)self;
        [self.pickerView show];
    }
    else {
        [self.blackClearBackGroundButton removeFromSuperview];
    }
}

- (void)removeSelectTableView {
    self.dropButton.selected = NO;
    self.clearButton.selected = NO;
    [self.blackClearBackGroundButton removeFromSuperview];
    [_singlePickerView hide];
    [_pickerView hide];
    [_yongTuPickerView hide];
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

- (UILabel *)needLabel {
    
    if(!_needLabel) {
        _needLabel = [[UILabel alloc] init];
        _needLabel.frame = CGRectMake(20.0f, self.yongTuEdit.frame.origin.y + self.yongTuEdit.frame.size.height + 10.0f, MainWidth - 20.0f*2, 13.0f);
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
        [_commitButton setTitle:@"我要发布" forState:UIControlStateNormal];
        _commitButton.layer.cornerRadius = 10.0f;
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton setBackgroundColor:_COLOR_HEX(0x00c78c)];
        
        [_commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (void)commitAction:(UIButton *)button {
    if ([self.contactPersonEdit.text isEqualToString:@""] || [self.telphoneEdit.text isEqualToString:@""] || [self.styleSelectEdit.text isEqualToString:@""] || [self.enterpriseNameEdit.text isEqualToString:@""] || [self.areaEdit.text isEqualToString:@""] || [self.mianJiEdit.text isEqualToString:@""] || [self.yongTuEdit.text isEqualToString:@""] || [self.photoPath isEqualToString:@""]) {
        [self.view showTipsView:@"亲~你还有信息未填写哦~"];
    }
    else {
        // 提交
        [self productSubscribe];
    }
}


- (void)productSubscribe {
    
    dispatch_group_enter(requestGroup);
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSDictionary *dic = @{
                          @"partyId" : partyId,
                          @"cooperationType" : @"5",
                          @"contact" : self.contactPersonEdit.text,
                          @"contactNumber" : self.telphoneEdit.text,
                          @"enterpriseName":self.enterpriseNameEdit.text,
                          @"locationArea":self.areaEdit.text,
                          @"cooperationIntention":self.styleSelectEdit.text,
                          @"area":self.mianJiEdit.text,
                          @"spacePhotograph":self.photoPath,
                          @"usage":self.yongTuEdit.text,
                          @"remark" : self.needTextView.text,
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
