//
//  InvoiceApplyViewController.m
//  VSProject
//
//  Created by apple on 5/26/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "InvoiceApplyViewController.h"
#import "BCNetWorkTool.h"
#import "PlaceholderTextView.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "BCNetWorkTool.h"
#import "InvoiceInfoView.h"
#import "InvoiceUserView.h"
#import "Masonry.h"
#import "PolicySelectCItyAreaView.h"
#import "NewPolicyManager.h"
#import "MultiPickerView.h"

@interface InvoiceApplyViewController () <UITextFieldDelegate,UITextViewDelegate,MultiPickerViewDelegate>
{
    NewPolicyManager *manger;
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIView *appointmentView; // 存放所有控件

@property (nonatomic, strong) UIView *orderInfoView; //订单信息
@property (nonatomic, strong) UIView *invoiceInfoView; //发票信息
@property (nonatomic, strong) UIButton *enterpriseButton;
@property (nonatomic, strong) UIButton *personalButton;
@property (nonatomic, strong) NSString *titleType;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextField *taxesIdTextField;
@property (nonatomic, strong) UIView *invoiceUserView; //发票用户信息
@property (nonatomic, strong) UITextField *contactsTextField; //联系人
@property (nonatomic, strong) UITextField *contactNumberTextField; //联系电话
@property (nonatomic, strong) UITextField *cityTextField;
@property (nonatomic, strong) UITextField *addressTextView; //地址
@property (nonatomic, strong) PolicySelectCItyAreaView *policySelectCItyAreaView;
@property (nonatomic, strong) UIButton *commitButton; // 提交按钮

@property (nonatomic, strong) UIButton *blackClearView;

@end

@implementation InvoiceApplyViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.autoresizesSubviews = NO;
    
    [self vs_setTitleText:@"发票信息填写"];
    
    self.view.backgroundColor = _COLOR_HEX(0xf9f9f9);
    
    requestGroup = dispatch_group_create();
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - 64.0f)];
    [scrollView setContentSize:self.appointmentView.frame.size];
    [scrollView addSubview:self.appointmentView];
    [self.view addSubview:scrollView];
    
    manger = [[NewPolicyManager alloc] init];
    [self getCityAndDistrict];
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
    if (self.contactsTextField.text.length > 0 &&
        self.contactNumberTextField.text.length > 0 &&
        self.addressTextView.text.length > 0 ) {
        
        if (self.contactNumberTextField.text.length == 11 && [self.contactNumberTextField.text hasPrefix:@"1"]) {
            [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.commitButton setEnabled:YES];
        }
    }
}

- (UIView *)appointmentView {
    
    if (!_appointmentView) {
        _appointmentView = [[UIView alloc] init];
        _appointmentView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 44.0f);
        
        [_appointmentView addSubview:self.orderInfoView];
        [_appointmentView addSubview:self.invoiceInfoView];
        [_appointmentView addSubview:self.invoiceUserView];
        [_appointmentView addSubview:self.commitButton];
        [_appointmentView setFrame:CGRectMake(0, 0, MainWidth, self.commitButton.frame.origin.y + self.commitButton.frame.size.height)];
    }
    return _appointmentView;
}

- (UIView *)orderInfoView {
    if (!_orderInfoView) {
        _orderInfoView = [[UIView alloc] initWithFrame:CGRectMake(11.0f, 11.0f, __SCREEN_WIDTH__ - 22.0f, 84.0f)];
        [_orderInfoView setBackgroundColor:ColorWithHex(0xffffff, 1.0f)];
        [_orderInfoView.layer setCornerRadius:5.0f];
        [_orderInfoView.layer setShadowColor:ColorWithHex(0x000000, 1.0f).CGColor];
        [_orderInfoView.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
        [_orderInfoView.layer setShadowOpacity:0.2f];
        
        UILabel *orderIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 24, _orderInfoView.frame.size.width - 28, 13.0f)];
        [orderIdLabel setFont:[UIFont systemFontOfSize:13]];
        [orderIdLabel setTextColor:ColorWithHex(0x33333, 1.0f)];
        [orderIdLabel setText:[NSString stringWithFormat:@"订单编号：%@",self.order.orderHeader.orderId?self.order.orderHeader.orderId:@""]];
        [_orderInfoView addSubview:orderIdLabel];
        
        UILabel *orderPrice = [[UILabel alloc] initWithFrame:CGRectMake(14, orderIdLabel.frame.origin.y + orderIdLabel.frame.size.height + 12.0f, _orderInfoView.frame.size.width - 28, 13.0f)];
        [orderPrice setFont:[UIFont systemFontOfSize:13]];
        [orderPrice setTextColor:ColorWithHex(0x33333, 1.0f)];
        [orderPrice setText:[NSString stringWithFormat:@"订单金额：￥%@",self.order.orderHeader.grandTotal?self.order.orderHeader.grandTotal:@""]];
        [_orderInfoView addSubview:orderPrice];
    }
    return _orderInfoView;
}

- (void)setLabelAndTextfieldSetting:(NSObject *)obj {
    if ([obj isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)obj;
        [label setFont:[UIFont systemFontOfSize:13.0f]];
        [label setTextColor:ColorWithHex(0x333333, 1.0f)];
    } else if ([obj isKindOfClass:[UITextField class]]) {
        UITextField *textfield = (UITextField *)obj;
        [textfield setFont:[UIFont systemFontOfSize:13.0f]];
        [textfield setTextColor:ColorWithHex(0x333333, 1.0f)];
    } else if ([obj isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)obj;
        [textView setFont:[UIFont systemFontOfSize:13.0f]];
        [textView setTextColor:ColorWithHex(0x333333, 1.0f)];
    }
}

- (UIView *)invoiceInfoView {
    if (!_invoiceInfoView) {
        _invoiceInfoView = [[UIView alloc] init];
        [_invoiceInfoView setFrame:CGRectMake(0, self.orderInfoView.frame.origin.y + self.orderInfoView.frame.size.height + 10.0f, __SCREEN_WIDTH__, 160.0f)];
        [_invoiceInfoView setClipsToBounds:YES];
        [_invoiceInfoView setBackgroundColor:ColorWithHex(0xffffff, 1.0f)];
        
        UILabel *invoiceTypeLabel = [[UILabel alloc] init];
        [self setLabelAndTextfieldSetting:invoiceTypeLabel];
        [invoiceTypeLabel setText:@"发票类型：增值税普通发票"];
        [_invoiceInfoView addSubview:invoiceTypeLabel];
        [invoiceTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceInfoView).with.offset(25.0f);
            make.top.equalTo(_invoiceInfoView).with.offset(10.0f);
            make.right.equalTo(_invoiceInfoView).with.offset(-25.0f);
            make.height.mas_equalTo(13);
        }];
        
        UILabel *titleTypeLabel = [[UILabel alloc] init];
        [self setLabelAndTextfieldSetting:titleTypeLabel];
        [titleTypeLabel setText:@"抬头类型："];
        [_invoiceInfoView addSubview:titleTypeLabel];
        [titleTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceInfoView).with.offset(25.0f);
            make.top.equalTo(invoiceTypeLabel.mas_bottom).with.offset(20.0f);
            make.height.mas_equalTo(13);
            make.width.mas_equalTo(70);
        }];
        
        _enterpriseButton = [[UIButton alloc] init];
        [_enterpriseButton setImage:__IMAGENAMED__(@"ic_xuanze_h") forState:UIControlStateNormal];
        [_enterpriseButton setTitleColor:ColorWithHex(0x35b38d, 1.0) forState:UIControlStateNormal];
        [_enterpriseButton setTitle:@"企业" forState:UIControlStateNormal];
        [_enterpriseButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_enterpriseButton setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 3)];
        [_enterpriseButton setTag:0];
        [_enterpriseButton addTarget:self action:@selector(chooseInvoiceType:) forControlEvents:UIControlEventTouchUpInside];
        [_invoiceInfoView addSubview:_enterpriseButton];
        [_enterpriseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleTypeLabel.mas_right).with.offset(5.0f);
            make.top.equalTo(invoiceTypeLabel.mas_bottom).with.offset(19.0f);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(50);
        }];
        
        _personalButton = [[UIButton alloc] init];
        [_personalButton setImage:__IMAGENAMED__(@"ic_xuanze_n") forState:UIControlStateNormal];
        [_personalButton setTitleColor:ColorWithHex(0xb7b7b7, 1.0) forState:UIControlStateNormal];
        [_personalButton setTitle:@"个人" forState:UIControlStateNormal];
        [_personalButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_personalButton setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 3)];
        [_personalButton setTag:1];
        [_personalButton addTarget:self action:@selector(chooseInvoiceType:) forControlEvents:UIControlEventTouchUpInside];
        [_invoiceInfoView addSubview:_personalButton];
        [_personalButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_enterpriseButton.mas_right).with.offset(25.0f);
            make.top.equalTo(invoiceTypeLabel.mas_bottom).with.offset(19.0f);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(50);
        }];
        
        UIView *line1 = [[UIView alloc] init];
        [line1 setBackgroundColor:ColorWithHex(0xb7b7b7, 1.0)];
        [_invoiceInfoView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceInfoView).with.offset(20.0f);
            make.top.equalTo(titleTypeLabel.mas_bottom).with.offset(15.0f);
            make.right.equalTo(_invoiceInfoView).with.offset(-20.0f);
            make.height.mas_equalTo(0.5f);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self setLabelAndTextfieldSetting:titleLabel];
        [titleLabel setText:@"发票抬头："];
        [_invoiceInfoView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceInfoView).with.offset(25.0f);
            make.top.equalTo(line1.mas_bottom).with.offset(15.0f);
            make.height.mas_equalTo(13);
            make.width.mas_equalTo(70);
        }];
        
        _titleTextField = [[UITextField alloc] init];
        [self setLabelAndTextfieldSetting:_titleTextField];
        [_titleTextField setPlaceholder:@"(必填)"];
        [_invoiceInfoView addSubview:_titleTextField];
        [_titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).with.offset(5.0f);
            make.right.equalTo(_invoiceInfoView).with.offset(25.0f);
            make.top.equalTo(line1.mas_bottom).with.offset(10.0f);
            make.height.mas_equalTo(23);
        }];
        
        UIView *line2 = [[UIView alloc] init];
        [line2 setBackgroundColor:ColorWithHex(0xb7b7b7, 1.0)];
        [_invoiceInfoView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceInfoView).with.offset(20.0f);
            make.top.equalTo(titleLabel.mas_bottom).with.offset(15.0f);
            make.right.equalTo(_invoiceInfoView).with.offset(-20.0f);
            make.height.mas_equalTo(0.5f);
        }];
        
        UILabel *taxesIdLabel = [[UILabel alloc] init];
        [self setLabelAndTextfieldSetting:taxesIdLabel];
        [taxesIdLabel setText:@"企业税号："];
        [_invoiceInfoView addSubview:taxesIdLabel];
        [taxesIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceInfoView).with.offset(25.0f);
            make.top.equalTo(line2.mas_bottom).with.offset(15.0f);
            make.height.mas_equalTo(13);
            make.width.mas_equalTo(70);
        }];
        
        _taxesIdTextField = [[UITextField alloc] init];
        [self setLabelAndTextfieldSetting:_taxesIdTextField];
        [_taxesIdTextField setPlaceholder:@"(必填)"];
        [_invoiceInfoView addSubview:_taxesIdTextField];
        [_taxesIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(taxesIdLabel.mas_right).with.offset(5.0f);
            make.right.equalTo(_invoiceInfoView).with.offset(25.0f);
            make.top.equalTo(line2.mas_bottom).with.offset(10.0f);
            make.height.mas_equalTo(23);
        }];
    }
    return _invoiceInfoView;
}

- (void)chooseInvoiceType:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    if (tag == 0) {
        self.titleType = @"ENTERPRISE";
        [_enterpriseButton setImage:__IMAGENAMED__(@"ic_xuanze_h") forState:UIControlStateNormal];
        [_enterpriseButton setTitleColor:ColorWithHex(0x35b38d, 1.0) forState:UIControlStateNormal];
        [_personalButton setImage:__IMAGENAMED__(@"ic_xuanze_n") forState:UIControlStateNormal];
        [_personalButton setTitleColor:ColorWithHex(0xb7b7b7, 1.0) forState:UIControlStateNormal];
        
        [_invoiceInfoView setFrame:CGRectMake(0, self.orderInfoView.frame.origin.y + self.orderInfoView.frame.size.height + 10.0f, __SCREEN_WIDTH__, 160.0f)];
        [_invoiceUserView setFrame:CGRectMake(0, self.invoiceInfoView.frame.origin.y + self.invoiceInfoView.frame.size.height + 10.0f, __SCREEN_WIDTH__, 200.0f)];
        [_commitButton setFrame:CGRectMake(25.0f, self.invoiceUserView.frame.origin.y + self.invoiceUserView.frame.size.height + 15.0f, MainWidth - 50.0f, 49.0f)];
    } else {
        self.titleType = @"PERSONAL";
        [_personalButton setImage:__IMAGENAMED__(@"ic_xuanze_h") forState:UIControlStateNormal];
        [_personalButton setTitleColor:ColorWithHex(0x35b38d, 1.0) forState:UIControlStateNormal];
        [_enterpriseButton setImage:__IMAGENAMED__(@"ic_xuanze_n") forState:UIControlStateNormal];
        [_enterpriseButton setTitleColor:ColorWithHex(0xb7b7b7, 1.0) forState:UIControlStateNormal];
        
        [_invoiceInfoView setFrame:CGRectMake(0, self.orderInfoView.frame.origin.y + self.orderInfoView.frame.size.height + 10.0f, __SCREEN_WIDTH__, 160.0f - 23.0f - 15.0f - 10.0f)];
        [_invoiceUserView setFrame:CGRectMake(0, self.invoiceInfoView.frame.origin.y + self.invoiceInfoView.frame.size.height + 10.0f, __SCREEN_WIDTH__, 200.0f)];
        [_commitButton setFrame:CGRectMake(25.0f, self.invoiceUserView.frame.origin.y + self.invoiceUserView.frame.size.height + 15.0f, MainWidth - 50.0f, 49.0f)];
    }
}

- (UIView *)invoiceUserView {
    if (!_invoiceUserView) {
        _invoiceUserView = [[UIView alloc] init];
        [_invoiceUserView setFrame:CGRectMake(0, self.invoiceInfoView.frame.origin.y + self.invoiceInfoView.frame.size.height + 10.0f, __SCREEN_WIDTH__, 200.0f)];
        [_invoiceUserView setBackgroundColor:ColorWithHex(0xffffff, 1.0f)];
        
        UILabel *contactsLabel = [[UILabel alloc] init];
        [self setLabelAndTextfieldSetting:contactsLabel];
        [contactsLabel setText:@"联 系 人："];
        [_invoiceUserView addSubview:contactsLabel];
        [contactsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceUserView).with.offset(25.0f);
            make.top.equalTo(_invoiceUserView).with.offset(15.0f);
            make.height.mas_equalTo(13);
            make.width.mas_equalTo(70);
        }];
        
        _contactsTextField = [[UITextField alloc] init];
        [self setLabelAndTextfieldSetting:_contactsTextField];
        [_contactsTextField setPlaceholder:@"(必填)"];
        [_invoiceUserView addSubview:_contactsTextField];
        [_contactsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contactsLabel.mas_right).with.offset(5.0f);
            make.right.equalTo(_invoiceUserView).with.offset(25.0f);
            make.top.equalTo(_invoiceUserView).with.offset(10.0f);
            make.height.mas_equalTo(23);
        }];
        
        UIView *line1 = [[UIView alloc] init];
        [line1 setBackgroundColor:ColorWithHex(0xb7b7b7, 1.0)];
        [_invoiceUserView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceUserView).with.offset(20.0f);
            make.top.equalTo(contactsLabel.mas_bottom).with.offset(15.0f);
            make.right.equalTo(_invoiceUserView).with.offset(-20.0f);
            make.height.mas_equalTo(0.5f);
        }];
        
        UILabel *contactNumberLabel = [[UILabel alloc] init];
        [self setLabelAndTextfieldSetting:contactNumberLabel];
        [contactNumberLabel setText:@"联系电话："];
        [_invoiceUserView addSubview:contactNumberLabel];
        [contactNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceUserView).with.offset(25.0f);
            make.top.equalTo(line1.mas_bottom).with.offset(15.0f);
            make.height.mas_equalTo(13);
            make.width.mas_equalTo(70);
        }];
        
        _contactNumberTextField = [[UITextField alloc] init];
        [self setLabelAndTextfieldSetting:_contactNumberTextField];
        [_contactNumberTextField setPlaceholder:@"(必填)"];
        [_invoiceUserView addSubview:_contactNumberTextField];
        [_contactNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contactNumberLabel.mas_right).with.offset(5.0f);
            make.right.equalTo(_invoiceUserView).with.offset(25.0f);
            make.top.equalTo(line1.mas_bottom).with.offset(10.0f);
            make.height.mas_equalTo(23);
        }];
        
        UIView *line2 = [[UIView alloc] init];
        [line2 setBackgroundColor:ColorWithHex(0xb7b7b7, 1.0)];
        [_invoiceUserView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceUserView).with.offset(20.0f);
            make.top.equalTo(contactNumberLabel.mas_bottom).with.offset(15.0f);
            make.right.equalTo(_invoiceUserView).with.offset(-20.0f);
            make.height.mas_equalTo(0.5f);
        }];
        
        UILabel *addressLabel = [[UILabel alloc] init];
        [self setLabelAndTextfieldSetting:addressLabel];
        [addressLabel setText:@"寄送地址："];
        [_invoiceUserView addSubview:addressLabel];
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceUserView).with.offset(25.0f);
            make.top.equalTo(line2.mas_bottom).with.offset(15.0f);
            make.height.mas_equalTo(13);
            make.width.mas_equalTo(70);
        }];
        
        _cityTextField = [[UITextField alloc] init];
        [self setLabelAndTextfieldSetting:_cityTextField];
        [_cityTextField setPlaceholder:@"请选择地址"];
        [_invoiceUserView addSubview:_cityTextField];
        [_cityTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(addressLabel.mas_right).with.offset(5.0f);
            make.right.equalTo(_invoiceUserView).with.offset(25.0f);
            make.top.equalTo(line2.mas_bottom).with.offset(10.0f);
            make.height.mas_equalTo(23);
        }];
        
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        [arrowImageView setImage:__IMAGENAMED__(@"usercenter_08")];
        [_invoiceUserView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_invoiceUserView).with.offset(-25.0f);
            make.top.equalTo(line2.mas_bottom).with.offset(14.0f);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(7);
        }];
        
        UIButton *chooseAddressButton = [[UIButton alloc] init];
        [chooseAddressButton addTarget:self action:@selector(chooseCityAction) forControlEvents:UIControlEventTouchUpInside];
        [_invoiceUserView addSubview:chooseAddressButton];
        [chooseAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(addressLabel.mas_right).with.offset(5.0f);
            make.right.equalTo(_invoiceUserView).with.offset(25.0f);
            make.top.equalTo(line2.mas_bottom).with.offset(10.0f);
            make.height.mas_equalTo(23);
        }];
        
        UIView *line3 = [[UIView alloc] init];
        [line3 setBackgroundColor:ColorWithHex(0xffffff, 1.0)];
        [_invoiceUserView addSubview:line3];
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceUserView).with.offset(20.0f);
            make.top.equalTo(addressLabel.mas_bottom).with.offset(15.0f);
            make.right.equalTo(_invoiceUserView).with.offset(-20.0f);
            make.height.mas_equalTo(0.5f);
        }];
        
        _addressTextView = [[UITextField alloc] init];
        [self setLabelAndTextfieldSetting:_addressTextView];
        [_addressTextView setPlaceholder:@"详细地址"];
        [_addressTextView setTextAlignment:NSTextAlignmentLeft];
        _addressTextView.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [_invoiceUserView addSubview:_addressTextView];
        [_addressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_invoiceUserView).with.offset(25.0f);
            make.right.equalTo(_invoiceUserView).with.offset(25.0f);
            make.top.equalTo(line3.mas_bottom).with.offset(0.0f);
            make.height.mas_equalTo(50);
        }];
    }
    return _invoiceUserView;
}

- (PolicySelectCItyAreaView *)policySelectCItyAreaView {
    if (!_policySelectCItyAreaView) {
        _policySelectCItyAreaView = [[PolicySelectCItyAreaView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ * 670 / 1334)];
        [_policySelectCItyAreaView setShoulChooseForOnlyOne:YES];
        __weak typeof(&*self) weakSelf = self;
        [_policySelectCItyAreaView setOnSelectedAreaBlock:^(CityAreaModel *cityAreaModel,NSMutableArray *selectedAreas,NSString *selectedAreasString){
            if (![selectedAreasString isEqualToString:@""]) {
                //部分选择，拼接展示字段
                NSMutableString *displayString = [[NSMutableString alloc] init];
                for (AreaModel *selModel in selectedAreas) {
                    if (displayString.length == 0) {
                        [displayString appendString:selModel.areaName];
                    } else {
                        [displayString appendString:@","];
                        [displayString appendString:selModel.areaName];
                    }
                }
                [weakSelf.cityTextField setText:[NSString stringWithFormat:@"%@%@",cityAreaModel.cityName,displayString]];
            } else {
                //全部
                if (![cityAreaModel.cityName isEqualToString:@""]) {
                    [weakSelf.cityTextField setText:cityAreaModel.cityName];
                }
            }
            [weakSelf.policySelectCItyAreaView removeFromSuperview];
            [weakSelf.blackClearView removeFromSuperview];
        }];
    }
    return _policySelectCItyAreaView;
}

- (UIButton *)blackClearView {
    if (!_blackClearView) {
        _blackClearView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 0)];
        [_blackClearView setBackgroundColor:ColorWithHex(0x000000, 0.3)];
        [_blackClearView addTarget:self action:@selector(removeChooseCity) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blackClearView;
}

- (void)removeChooseCity {
    [self.policySelectCItyAreaView removeFromSuperview];
    [self.blackClearView removeFromSuperview];
}

- (void)chooseCityAction {
    MultiPickerView *pickerView = [[MultiPickerView alloc]initWithFrame:self.view.bounds];
    pickerView.delegate = (id<MultiPickerViewDelegate>)self;
    [pickerView show];
    
//    [self.view addSubview:self.blackClearView];
//    [self.blackClearView addSubview:self.policySelectCItyAreaView];
}

- (void)getCityAndDistrict {
    [manger onRequestCityAndDistrictSuccess:^(NSDictionary *responseObj) {
        NSError *err;
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSArray *list = [CityAreaModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"cityAreaList"] error:&err];
        
        for (CityAreaModel *c_model in list) {
            c_model.areaList = [AreaModel arrayOfModelsFromDictionaries:c_model.areaList];
        }
        
        NSLog(@"%@",list);
        
        [self.policySelectCItyAreaView onSetCityList:list];
        
        if ([list count] > 0) {
            [self vs_showRightButton:YES];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    } failure:^(NSError *error) {
        
    }];
}

- (UIButton *)commitButton {
    
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] init];
        _commitButton = [[UIButton alloc] initWithFrame:CGRectMake(25.0f, self.invoiceUserView.frame.origin.y + self.invoiceUserView.frame.size.height + 15.0f, MainWidth - 50.0f, 49.0f)];
        _commitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _commitButton.layer.cornerRadius = 10.0f;
        [_commitButton setBackgroundColor:_COLOR_HEX(0x00c78c)];
        [_commitButton setTitle:@"提交申请" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

#pragma mark -- MultiPickerViewDelegate

- (void)MultiPickerView:(MultiPickerView *)pickerView leftValue:(NSString *)leftValue middleValue:(NSString *)middleValue rightValue:(NSString *)rightValue {
    if (leftValue && middleValue && rightValue) {
        if ([middleValue isEqualToString:@"市辖区"]||[middleValue isEqualToString:@"县"]) {
            self.cityTextField.text = [NSString stringWithFormat:@"%@%@",leftValue,rightValue];
        }else {
            self.cityTextField.text = [NSString stringWithFormat:@"%@%@%@",leftValue,middleValue,rightValue];
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

- (void)commitAction:(UIButton *)button {
    BOOL shouldSubmit = YES;
    if ([self.titleTextField.text isEqualToString:@""]) {
        shouldSubmit = NO;
    }
    
    if ([self.titleType isEqualToString:@"ENTERPRISE"]) {
        if ([self.taxesIdTextField.text isEqualToString:@""]) {
            shouldSubmit = NO;
        }
    }
    
    if ([self.contactNumberTextField.text isEqualToString:@""]) {
        shouldSubmit = NO;
    }
    
    if ([self.contactsTextField.text isEqualToString:@""]) {
        shouldSubmit = NO;
    }
    
    if (shouldSubmit) {
        //信息都填了，手机号校验
        if ([self.contactNumberTextField.text hasPrefix:@"1"] && self.contactNumberTextField.text.length == 11) {
            // 提交
            [self productSubscribe];
        } else {
            [self.view showTipsView:@"请输入11位手机号码"];
        }
        
    } else {
        PXAlertView *alertView = [PXAlertView showAlertWithTitle:@"提示" message:@"亲~你还有信息未填写哦~" cancelTitle:@"确定" otherTitle:nil completion:^(BOOL cancelled, NSInteger buttonIndex) {
        }];
        
        [alertView setBackgroundColor:[UIColor whiteColor]];
        [alertView setTitleColor:[UIColor grayColor]];
        [alertView setMessageColor:[UIColor grayColor]];
        [alertView setCancelButtonTextColor:[UIColor grayColor]];
        [alertView setOtherButtonTextColor:[UIColor grayColor]];
    }
    
}

- (void)productSubscribe {
    
    dispatch_group_enter(requestGroup);
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSDictionary *dic = @{
                          @"orderId" : self.order.orderHeader.orderId,
                          @"invoiceType" : @"1",
                          @"titleType" : self.titleType,
                          @"title" : self.titleTextField.text,
                          @"taxesId" : self.taxesIdTextField.text,
                          @"contacts" : self.contactsTextField.text,
                          @"contactNumber": self.contactNumberTextField.text,
                          @"address": [NSString stringWithFormat:@"%@%@",self.cityTextField.text,self.addressTextView.text],
                          @"userLoginId" : partyId,
                          };
    
    NSString *jsonString = [VSPageRoute dictionaryToJson:dic];
    dic = @{@"content":jsonString};
    
    __weak typeof(self)weakself = self;
    [self vs_showLoading];
    [BCNetWorkTool executePostNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/apply-invoice/version/1.5.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        [weakself.view showTipsView:@"申请成功"];
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
