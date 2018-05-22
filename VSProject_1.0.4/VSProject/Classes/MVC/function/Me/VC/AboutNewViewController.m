//
//  AboutNewViewController.m
//  VSProject
//
//  Created by pangchao on 16/12/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "AboutNewViewController.h"
#import "AgreementViewController.h"

@interface AboutNewViewController ()

@property (nonatomic, strong) UIImageView *logoImagView;

@property (nonatomic, strong) UILabel *versionLabel;

@property (nonatomic, strong) UIButton *companyPrivateButton; // 隐私条款

@property (nonatomic, strong) UIView *separateLineView;

@property (nonatomic, strong) UIButton *disclaimerButton; // 免责声明

@property (nonatomic, strong) UILabel *copyrightLabel; // 版权所有

@property (nonatomic, strong) UILabel *registrationCodeLabel; // 公司注册编码

@end

@implementation AboutNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于时在";
    self.view.backgroundColor = _COLOR_HEX(0xf3f3f3);
    
    [self.view addSubview:self.logoImagView];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.companyPrivateButton];
    [self.view addSubview:self.separateLineView];
    [self.view addSubview:self.disclaimerButton];
    [self.view addSubview:self.copyrightLabel];
    [self.view addSubview:self.registrationCodeLabel];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [self.versionLabel setText:[NSString stringWithFormat:@"V%@", app_Version]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIImageView *)logoImagView {
    
    if (!_logoImagView) {
        _logoImagView = [[UIImageView alloc] init];
        _logoImagView.frame = CGRectMake((MainWidth - 74.0f)/2, 64.0f + 30.0f, 74.0f, 74.0f);
        _logoImagView.image = [UIImage imageNamed:@"me_aboutlogo"];
    }
    return _logoImagView;
}

- (UILabel *)versionLabel {
    
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.frame = CGRectMake(0, self.logoImagView.frame.origin.y + 74.0f + 15.0f, MainWidth, 13.0f);
        _versionLabel.font = [UIFont systemFontOfSize:13.0f];
        _versionLabel.textColor = _COLOR_HEX(0x333333);
        _versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLabel;
}

- (UILabel *)registrationCodeLabel {
    
    if (!_registrationCodeLabel) {
        _registrationCodeLabel = [[UILabel alloc] init];
        _registrationCodeLabel.frame = CGRectMake((MainWidth - 160.0f)/2, MainHeight - 40.0f - 20.0f, 160.0f, 40.0f);
        _registrationCodeLabel.font = [UIFont systemFontOfSize:10.0f];
        _registrationCodeLabel.textColor = _COLOR_HEX(0x666666);
        _registrationCodeLabel.textAlignment = NSTextAlignmentCenter;
        _registrationCodeLabel.numberOfLines = 0;
        _registrationCodeLabel.text = @"Copyright@2011-2015 Ruitianxia\nAll Rights Reserved.";
    }
    return _registrationCodeLabel;
}

- (UILabel *)copyrightLabel {
    
    if (!_copyrightLabel) {
        _copyrightLabel = [[UILabel alloc] init];
        _copyrightLabel.frame = CGRectMake(0, self.registrationCodeLabel.frame.origin.y - 12.5f - 10.0f, MainWidth, 10.0f);
        _copyrightLabel.font = [UIFont systemFontOfSize:10.0f];
        _copyrightLabel.textColor = _COLOR_HEX(0x666666);
        _copyrightLabel.textAlignment = NSTextAlignmentCenter;
        _copyrightLabel.text = @"北京睿天下新媒体信息技术有限公司    版权所有";
    }
    return _copyrightLabel;
}

- (UIButton *)companyPrivateButton {
    
    if (!_companyPrivateButton) {
        _companyPrivateButton = [[UIButton alloc] init];
        _companyPrivateButton.frame = CGRectMake((MainWidth - 60.0f*2 - 20.0f)/2, self.copyrightLabel.frame.origin.y - 30.0f - 13.0f, 60.0f, 13.0f);
        _companyPrivateButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_companyPrivateButton setTitleColor:_COLOR_HEX(0x353535) forState:UIControlStateNormal];
        [_companyPrivateButton setTitle:@"隐私条款" forState:UIControlStateNormal];
        
        [_companyPrivateButton addTarget:self action:@selector(actioncompanyPrivate:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _companyPrivateButton;
}

- (UIView *)separateLineView {
    
    if (!_separateLineView) {
        _separateLineView = [[UIView alloc] init];
        _separateLineView.frame = CGRectMake(self.companyPrivateButton.frame.origin.x + self.companyPrivateButton.frame.size.width + 5.0f, self.companyPrivateButton.frame.origin.y, 0.5f, 13.0f);
        _separateLineView.backgroundColor = _COLOR_HEX(0x353535);
    }
    return _separateLineView;
}

- (UIButton *)disclaimerButton {
    
    if (!_disclaimerButton) {
        _disclaimerButton = [[UIButton alloc] init];
        _disclaimerButton.frame = CGRectMake(self.separateLineView.frame.origin.x + self.separateLineView.frame.size.width + 5.0f, self.copyrightLabel.frame.origin.y - 30.0f - 13.0f, 60.0f, 13.0f);
        _disclaimerButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_disclaimerButton setTitleColor:_COLOR_HEX(0x353535) forState:UIControlStateNormal];
        [_disclaimerButton setTitle:@"免费声责" forState:UIControlStateNormal];
        
        [_disclaimerButton addTarget:self action:@selector(actionDisclaimer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _disclaimerButton;
}

- (void)actioncompanyPrivate:(UIButton *)button {
    
    AgreementViewController *controller = [[AgreementViewController alloc]init];
    controller.titleName = @"企业隐私条款";
    controller.resourceName = @"EnterprisePrivacyClause";
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionDisclaimer:(UIButton *)button {
    
    AgreementViewController *controller = [[AgreementViewController alloc]init];
    controller.titleName = @"免责声明";
    controller.resourceName = @"Disclaimer";
    [self.navigationController pushViewController:controller animated:YES];
}

@end
