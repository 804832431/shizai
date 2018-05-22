//
//  ContactUsViewController.m
//  VSProject
//
//  Created by pangchao on 16/12/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ContactUsViewController.h"
#import "PXAlertView+Customization.h"
#import "PXAlertView.h"

@interface ContactUsViewController ()

@property (nonatomic, strong) UIView *contactTelView;
@property (nonatomic, strong) UILabel *telephoneNoLabel;

@property (nonatomic, strong) UIView *contactMailView;

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self vs_setTitleText:@"联系我们"];
    
    self.view.backgroundColor = _COLOR_HEX(0xf3f3f3);
    
    [self.view addSubview:self.contactTelView];
    [self.view addSubview:self.contactMailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//拨打电话
- (void)callPhoneNunber:(NSString *)phoneNunber {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneNunber]]];
}

- (UIView *)contactTelView {
    
    if (!_contactTelView) {
        _contactTelView = [[UIView alloc] init];
        _contactTelView.frame = CGRectMake(0, 7.5f, MainWidth, 88.0f);
        _contactTelView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(20.0f, 15.0f, MainWidth - 40.0f, 15.0f);
        titleLabel.font = [UIFont systemFontOfSize:15.0f];
        titleLabel.textColor = _COLOR_HEX(0x333333);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"客服电话";
        [_contactTelView addSubview:titleLabel];
        
        UILabel *telephoneNoLabel = [[UILabel alloc] init];
        telephoneNoLabel.frame = CGRectMake(20.0f, 15.0f + 15.0f + 30.0f, GetWidth(titleLabel), 15.0f);
        telephoneNoLabel.font = [UIFont systemFontOfSize:15.0f];
        telephoneNoLabel.textColor = _COLOR_HEX(0x333333);
        telephoneNoLabel.textAlignment = NSTextAlignmentLeft;
        telephoneNoLabel.text = @"4008320087";
        self.telephoneNoLabel = telephoneNoLabel;
        [_contactTelView addSubview:telephoneNoLabel];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Actiondo:)];
        [_contactTelView addGestureRecognizer:tapGesture];
    }
    return _contactTelView;
}

- (void)Actiondo:(id)sender {
    
    PXAlertView *alertView = [PXAlertView showAlertWithTitle:@"提示" message:@"您确定要拨打客服电话吗？" cancelTitle:@"取消" otherTitle:@"确定" completion:^(BOOL cancelled, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self callPhoneNunber:self.telephoneNoLabel.text];
        }
    }];
    
    [alertView setBackgroundColor:[UIColor whiteColor]];
    [alertView setTitleColor:[UIColor grayColor]];
    [alertView setMessageColor:[UIColor grayColor]];
    [alertView setCancelButtonTextColor:[UIColor grayColor]];
    [alertView setOtherButtonTextColor:[UIColor grayColor]];
}

- (UIView *)contactMailView {
    
    if (!_contactMailView) {
        _contactMailView = [[UIView alloc] init];
        _contactMailView.frame = CGRectMake(0, self.contactTelView.frame.origin.y + self.contactTelView.frame.size.height + 7.5f, MainWidth, 132.0f);
        _contactMailView.backgroundColor = [UIColor whiteColor];
        
        UILabel *mailTitleLabel = [[UILabel alloc] init];
        mailTitleLabel.frame = CGRectMake(20.0f, 15.0f, MainWidth - 20.0f*2, 15.0f);
        mailTitleLabel.font = [UIFont systemFontOfSize:15.0f];
        mailTitleLabel.textColor = _COLOR_HEX(0x333333);
        mailTitleLabel.textAlignment = NSTextAlignmentLeft;
        mailTitleLabel.text = @"合作邮箱";
        [_contactMailView addSubview:mailTitleLabel];
        
        CGFloat offsetY = mailTitleLabel.frame.origin.y + mailTitleLabel.frame.size.height;
        for (int i=0; i<2; ++i) {
            UILabel *mailLabel = [[UILabel alloc] init];
            mailLabel.frame = CGRectMake(20.0f, offsetY + 30.0f, MainWidth - 20.0f*2, 15.0f);
            mailLabel.font = [UIFont systemFontOfSize:15.0f];
            mailLabel.textColor = _COLOR_HEX(0x333333);
            mailLabel.textAlignment = NSTextAlignmentLeft;
            if (i == 0) {
                mailLabel.text = @"zhanglu@rtianxia.com";
            }
            else {
                mailLabel.text = @"wunan@rtianxia.com";
            }
            offsetY += (30.0f + 15.0f);
            [_contactMailView addSubview:mailLabel];
        }
    }
    return _contactMailView;
}

@end
