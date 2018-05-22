//
//  AuthStatusPassOrRejectViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import "AuthStatusPassOrRejectViewController.h"
#import "TelPhoneCallAlertView.h"
#import "AuthHistoryDTO.h"

@interface AuthStatusPassOrRejectViewController ()

@end

@implementation AuthStatusPassOrRejectViewController

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)contentTitleLabel{
    if (_contentTitleLabel == nil) {
        _contentTitleLabel = [UILabel new];
        _contentTitleLabel.font = [UIFont systemFontOfSize:12];
        _contentTitleLabel.textColor = _Colorhex(0x2f9f7e);
        _contentTitleLabel.text = @"认证信息";
    }
    return _contentTitleLabel;
}

-(UILabel *)enterpriseName{
    if (_enterpriseName == nil) {
        _enterpriseName = [UILabel new];
        _enterpriseName.textColor = _Colorhex(0x444444);
        _enterpriseName.text = @"企业名称";
        _enterpriseName.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseName;
}
- (UILabel *)enterpriseLegalPerson{
    if (_enterpriseLegalPerson == nil) {
        _enterpriseLegalPerson = [UILabel new];
        _enterpriseLegalPerson.textColor = _Colorhex(0x444444);
        _enterpriseLegalPerson.text = @"法人姓名";
        _enterpriseLegalPerson.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseLegalPerson;
}

-(UILabel *)contactName{
    if (_contactName == nil) {
        _contactName = [UILabel new];
        _contactName.textColor = _Colorhex(0x444444);
        _contactName.text = @"联系人";
        _contactName.font = [UIFont systemFontOfSize:12];
    }
    return _contactName;
}
- (UILabel *)contactNumber{
    if (_contactNumber == nil) {
        _contactNumber = [UILabel new];
        _contactNumber.textColor = _Colorhex(0x444444);
        _contactNumber.text = @"联系方式";
        _contactNumber.font = [UIFont systemFontOfSize:12];
    }
    return _contactNumber;
}

- (UILabel *)enterpriseIdentity{
    if (_enterpriseIdentity == nil) {
        _enterpriseIdentity = [UILabel new];
        _enterpriseIdentity.textColor = _Colorhex(0x444444);
        _enterpriseIdentity.text = @"企业工商注册号";
        _enterpriseIdentity.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseIdentity;
}

-(UILabel *)enterpriseNameContent{
    if (_enterpriseNameContent == nil) {
        _enterpriseNameContent = [UILabel new];
        _enterpriseNameContent.textColor = _Colorhex(0x777777);
        _enterpriseNameContent.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseNameContent;
}
- (UILabel *)enterpriseLegalPersonContent{
    if (_enterpriseLegalPersonContent == nil) {
        _enterpriseLegalPersonContent = [UILabel new];
        _enterpriseLegalPersonContent.textColor = _Colorhex(0x777777);
        _enterpriseLegalPersonContent.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseLegalPersonContent;
}

-(UILabel *)contactNameContent{
    if (_contactNameContent == nil) {
        _contactNameContent = [UILabel new];
        _contactNameContent.textColor = _Colorhex(0x777777);
        _contactNameContent.font = [UIFont systemFontOfSize:12];
    }
    return _contactNameContent;
}
- (UILabel *)contactNumberContent{
    if (_contactNumberContent == nil) {
        _contactNumberContent = [UILabel new];
        _contactNumberContent.textColor = _Colorhex(0x777777);
        _contactNumberContent.font = [UIFont systemFontOfSize:12];
    }
    return _contactNumberContent;
}

- (UILabel *)enterpriseIdentityContent{
    if (_enterpriseIdentityContent == nil) {
        _enterpriseIdentityContent = [UILabel new];
        _enterpriseIdentityContent.textColor = _Colorhex(0x777777);
        _enterpriseIdentityContent.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseIdentityContent;
}

-(UIView *)sepLineView{
    if (_sepLineView == nil) {
        _sepLineView = [UIView new];
        _sepLineView.backgroundColor = _Colorhex(0xc5c5c5);
    }
    return _sepLineView;
}

- (AuthStatusView *)statusView{
    if (_statusView == nil) {
        _statusView = [[[NSBundle mainBundle] loadNibNamed:@"AuthStatus" owner:nil  options:nil] lastObject];
    }
    return _statusView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"企业认证"];
    
    [self.view addSubview:self.statusView];
    
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.contentTitleLabel];
    
    [self.bgView addSubview:self.sepLineView];
    
    [self.bgView addSubview:self.enterpriseName];
    [self.bgView addSubview:self.enterpriseLegalPerson];
    [self.bgView addSubview:self.contactName];
    [self.bgView addSubview:self.contactNumber];
    [self.bgView addSubview:self.enterpriseIdentity];
    
    [self.bgView addSubview:self.enterpriseNameContent];
    [self.bgView addSubview:self.enterpriseLegalPersonContent];
    [self.bgView addSubview:self.contactNameContent];
    [self.bgView addSubview:self.contactNumberContent];
    [self.bgView addSubview:self.enterpriseIdentityContent];
    
    __weak typeof(self) weakSelf = self;
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(10 + 64);
        make.leading.equalTo(weakSelf.view);
        make.trailing.equalTo(weakSelf.view);
        make.height.equalTo(@70);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(90 + 64);
        make.leading.equalTo(weakSelf.view).offset(10);
        make.trailing.equalTo(weakSelf.view).offset(-10);
        make.height.equalTo(@150);
    }];
    
    
    
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView).offset(10);
        make.top.equalTo(weakSelf.bgView).offset(10);
    }];
    
    [self.sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView).offset(5);
        make.trailing.equalTo(weakSelf.bgView).offset(-5);
        make.height.equalTo(@1);
        make.top.equalTo(weakSelf.contentTitleLabel.mas_bottom).offset(10);
    }];
    
    [self.enterpriseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.sepLineView.mas_bottom).offset(10);
    }];
    
    [self.enterpriseNameContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.enterpriseName);
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
    [self.enterpriseLegalPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.enterpriseName.mas_bottom).offset(5);
    }];
    
    [self.enterpriseLegalPersonContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.enterpriseLegalPerson);
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
        
    }];
    
    [self.contactName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.enterpriseLegalPerson.mas_bottom).offset(5);
    }];
    
    [self.contactNameContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contactName);
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
    [self.contactNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.contactName.mas_bottom).offset(5);
    }];
    
    [self.contactNumberContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contactNumber);
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
    [self.enterpriseIdentity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.contactNumber.mas_bottom).offset(5);
    }];
    
    [self.enterpriseIdentityContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.enterpriseIdentity);
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
    
}

- (void)setDto:(AuthHistoryDTO *)dto{
    _dto = dto;
    
    
    self.enterpriseNameContent.text = dto.enterpriseName;
    self.enterpriseLegalPersonContent.text = dto.enterpriseLegalPerson;
    self.contactNameContent.text = dto.contactName;
    self.contactNumberContent.text = dto.contactNumber;
    self.enterpriseIdentityContent.text = dto.enterpriseIdentity;
    
    
}

- (void)setData:(AuthedEnterprise *)data{
    _data = data;
    
    self.enterpriseNameContent.text = data.bidder.enterpriseName;
    self.enterpriseLegalPersonContent.text = data.bidder.enterpriseLegalPerson;
    self.contactNameContent.text = data.bidder.contactName;
    self.contactNumberContent.text = data.bidder.contactNumber;
    self.enterpriseIdentityContent.text = data.bidder.enterpriseIdentity;
    
}

- (IBAction)playCall:(id)sender {
    
    [TelPhoneCallAlertView  showWithTelPHoneNum:@"4008320087"];
    
}

@end
