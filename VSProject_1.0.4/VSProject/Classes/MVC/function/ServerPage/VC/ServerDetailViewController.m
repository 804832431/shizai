//
//  ServerDetailViewController.m
//  VSProject
//
//  Created by pangchao on 16/12/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ServerDetailViewController.h"
#import "NewShareWebViewController.h"
#import "BannerDTO.h"
#import "VSAdsView.h"

@interface ServerDetailViewController ()
{
    
}

@property (nonatomic, strong) VSAdsView *adsView;

@property (nonatomic, strong) UIView *serverDetailView;

@property (nonatomic, strong) UIButton *payButton;

@property (nonatomic, strong) UILabel *projectNameLabel;    // 服务项目名称
@property (nonatomic, strong) UILabel *orderNumLabel;       // 订单数量
@property (nonatomic, strong) UILabel *priceLabel;          // 价格
@property (nonatomic, strong) UIButton *standardSelButton;  // 规格选择
@property (nonatomic, strong) UIButton *companyButton;      // 公司名称
@property (nonatomic, strong) UILabel *companyNameLabel;    // 公司名称

@property (nonatomic, strong) UIView *serverDetailBar;      // 服务介绍；服务说明；资费说明页签
@property (nonatomic, strong) UILabel *serverDetailLabel;   // 页签内容

@end

@implementation ServerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.adsView];
    [self.view addSubview:self.serverDetailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (VSAdsView *)adsView {
    
    if (!_adsView) {
        _adsView = [[VSAdsView alloc] init];
        [_adsView setBackgroundColor:[UIColor redColor]];
        [_adsView setFrame:CGRectMake(0, 64.0f, MainWidth, MainWidth * 406 / 1126)];
        __weak typeof(self) weakself = self;
        [_adsView setAdsClickBlock:^(id data) {
            if ([data isKindOfClass:[BannerDTO class]]) {
                BannerDTO *dto = (BannerDTO *)data;
                
                if ([dto.bannerDetail.uppercaseString hasPrefix:@"HTTP"]) {
                    
                    NSLog(@"%@",dto.bannerDetail);
                    
                    NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:dto.bannerDetail]];
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
            }
        }];
    }
    return _adsView;
}

- (UIView *)serverDetailView {
    
    if (!_serverDetailView) {
        _serverDetailView = [[UIView alloc] init];
        _serverDetailView.frame = CGRectMake(0, self.adsView.frame.origin.y + self.adsView.frame.size.height, MainWidth, MainHeight - 64.0f - self.adsView.frame.size.height - 50.0f - 5.0f);
        _serverDetailView.backgroundColor = [UIColor whiteColor];
        
        [_serverDetailView addSubview:self.projectNameLabel];
    }
    return _serverDetailView;
}

- (UILabel *)projectNameLabel {
    
    if (!_projectNameLabel) {
        _projectNameLabel = [[UILabel alloc] init];
        _projectNameLabel.frame = CGRectMake(12.0f, 20.0f, MainWidth - 12.0f*2, 15.0f);
        _projectNameLabel.font = [UIFont systemFontOfSize:15.0f];
        _projectNameLabel.textColor = _COLOR_HEX(0x353535);
        _projectNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _projectNameLabel;
}

- (UILabel *)orderNumLabel {
    
    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderNumLabel.font = [UIFont systemFontOfSize:13.0f];
        _orderNumLabel.textColor = _COLOR_HEX(0x999999);
        _orderNumLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _orderNumLabel;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.font = [UIFont systemFontOfSize:18.0f];
        _priceLabel.textColor = _COLOR_HEX(0xff7124);
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

- (UIButton *)standardSelButton {
    
    if (!_standardSelButton) {
        _standardSelButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _standardSelButton.backgroundColor = [UIColor whiteColor];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, (39.0f - 16.0f)/2, 16.0f, 16.0f)];
        iconImageView.image = [UIImage imageNamed:@""];
        [_standardSelButton addSubview:iconImageView];
        
        UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.origin.x + iconImageView.frame.size.width, (39.0f - 13.0f)/2, 60.0f, 13.0f)];
        titlelabel.textColor = _COLOR_HEX(0x333333);
        titlelabel.textAlignment = NSTextAlignmentLeft;
        titlelabel.font = [UIFont systemFontOfSize:13.0f];
        titlelabel.text = @"规格选择";
        [_standardSelButton addSubview:titlelabel];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MainWidth - 12.0f - 17.0f, (39.0f - 9.0f)/2, 17.0f, 9.0f)];
        arrowImageView.image = [UIImage imageNamed:@""];
        [_standardSelButton addSubview:arrowImageView];
        
        _standardSelButton.tag = 1004;
        [_standardSelButton addTarget:self action:@selector(serverDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _standardSelButton;
}

- (UIButton *)companyButton {
    
    if (!_companyButton) {
        _companyButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _companyButton.backgroundColor = [UIColor whiteColor];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, (39.0f - 16.0f)/2, 16.0f, 16.0f)];
        iconImageView.image = [UIImage imageNamed:@""];
        [_companyButton addSubview:iconImageView];
        
        UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.origin.x + iconImageView.frame.size.width, (39.0f - 13.0f)/2, 100.0f, 13.0f)];
        titlelabel.textColor = _COLOR_HEX(0x333333);
        titlelabel.textAlignment = NSTextAlignmentLeft;
        titlelabel.font = [UIFont systemFontOfSize:13.0f];
        titlelabel.text = @"规格选择";
        self.companyNameLabel = titlelabel;
        [_companyButton addSubview:titlelabel];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MainWidth - 12.0f - 17.0f, (39.0f - 9.0f)/2, 17.0f, 9.0f)];
        arrowImageView.image = [UIImage imageNamed:@""];
        [_companyButton addSubview:arrowImageView];
        
        _companyButton.tag = 1005;
        [_companyButton addTarget:self action:@selector(serverDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _companyButton;
}

- (UIView *)serverDetailBar {
    
    if (!_serverDetailBar) {
        _serverDetailBar = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    return _serverDetailBar;
}

- (UIButton *)payButton {
    
    if (!_payButton) {
        _payButton = [[UIButton alloc] init];
    }
    return _payButton;
}

- (void)serverDetailAction:(UIButton *)button {
    
}

@end
