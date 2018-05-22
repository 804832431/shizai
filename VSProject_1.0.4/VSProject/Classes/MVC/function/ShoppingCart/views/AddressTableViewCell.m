//
//  AddressTableViewCell.m
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "UIColor+TPCategory.h"


@implementation AddressTableViewCell

- (UIImageView *) bgImageView{
    
    if (_bgImageView == nil) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"收货地址bg"];
    }
    
    return _bgImageView;
}

- (UIImageView *) contactImageView{
    
    if (_contactImageView == nil) {
        _contactImageView = [UIImageView new];
        _contactImageView.image = [UIImage imageNamed:@"user"];
    }
    
    return _contactImageView;
}


- (UILabel *) contactName{
    
    if (_contactName == nil) {
        _contactName = [UILabel new];
        _contactName.font = [UIFont systemFontOfSize:12];
        _contactName.textColor = [UIColor colorFromHexRGB:@"505050"];
        _contactName.numberOfLines = 0;
        _contactName.text = @"联系人:";
        
    }
    
    return _contactName;
}

- (UILabel *) contactNameLabel{
    
    if (_contactNameLabel == nil) {
        _contactNameLabel = [UILabel new];
        _contactNameLabel.font = [UIFont systemFontOfSize:12];
        _contactNameLabel.textColor = [UIColor colorFromHexRGB:@"505050"];
        _contactNameLabel.numberOfLines = 0;
        
    }
    
    return _contactNameLabel;
}

- (UIImageView *) phoneImageView{
    
    if (_phoneImageView == nil) {
        _phoneImageView = [UIImageView new];
        _phoneImageView.image = [UIImage imageNamed:@"phone"];
    }
    
    return _phoneImageView;
}

- (UILabel *) phoneLabel{
    
    if (_phoneLabel == nil) {
        _phoneLabel = [UILabel new];
        _phoneLabel.font = [UIFont systemFontOfSize:12];
        _phoneLabel.textColor = [UIColor colorFromHexRGB:@"505050"];
    }
    
    return _phoneLabel;
}

- (UILabel *) addressName{
    
    if (_addressName == nil) {
        _addressName = [UILabel new];
        _addressName.font = [UIFont systemFontOfSize:12];
        _addressName.textColor = [UIColor colorFromHexRGB:@"505050"];
        
        
    }
    
    return _addressName;
}

- (UILabel *) addressLabel{
    
    if (_addressLabel == nil) {
        _addressLabel = [UILabel new];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textColor = [UIColor colorFromHexRGB:@"505050"];
        _addressLabel.numberOfLines = 0;
        
    }
    
    return _addressLabel;
}

- (UIImageView *)detailImageView{
    
    if (_detailImageView == nil) {
        
        _detailImageView = [UIImageView new];
        _detailImageView.image = [UIImage imageNamed:@"修改"];
    }
    
    return _detailImageView;
}

#pragma mark -

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView addSubview:self.contactImageView];
        [self.bgImageView addSubview:self.contactName];
        [self.bgImageView addSubview:self.contactNameLabel];
        [self.bgImageView addSubview:self.phoneImageView];
        [self.bgImageView addSubview:self.phoneLabel];
        [self.bgImageView addSubview:self.addressName];
        [self.bgImageView addSubview:self.addressLabel];
        [self.bgImageView addSubview:self.detailImageView];
        
        
        
        [self updateConstraintsForSubViews];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    self.contactNameLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width/2 - 60;
    self.addressLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width  - 100;
    
    return self;
}

- (void)setAddress:(AdressModel *)address{
    
    _address = address;
    
    self.phoneLabel.text =  [NSString stringWithFormat:@"%@",address.contactNumber.length > 0?address.contactNumber:@"    "];
    self.contactNameLabel.text = [NSString stringWithFormat:@"%@",address.recipient.length > 0?address.recipient:@"     "];
    NSString *addressStr = [NSString stringWithFormat:@"%@%@",(address.zipCode.length > 0?address.zipCode:@""),(address.address.length > 0? address.address :@"    ")];
    
    self.addressLabel.text = [NSString stringWithFormat:@"%@",addressStr];
}


- (void)updateConstraintsForSubViews{
    
    __weak typeof(&*self) weakSelf = self;
    
    self.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 9999);
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).offset(13);
        make.bottom.equalTo(weakSelf.contentView).offset(-13);
    }];
    
    [self.contactImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgImageView).offset(18);
        make.top.equalTo(weakSelf.bgImageView).offset(18);
    }];
    
    [self.contactName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contactImageView.mas_trailing).offset(6);
        make.top.equalTo(weakSelf.bgImageView).offset(15);
    }];
    
    [self.contactNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contactName.mas_trailing);
        make.top.equalTo(weakSelf.bgImageView).offset(15);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/2-60
                               );
    }];
    
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contactNameLabel.mas_trailing).offset(25);
        make.centerY.equalTo(weakSelf.contactImageView);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.phoneImageView.mas_trailing).offset(6);
        make.centerY.equalTo(weakSelf.phoneImageView);
    }];
    
    [self.addressName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contactImageView);
        make.top.equalTo(weakSelf.contactNameLabel.mas_bottom).offset(10);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.addressName.mas_trailing);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 100);
        make.top.equalTo(weakSelf.contactNameLabel.mas_bottom).offset(10);
        make.bottom.equalTo(weakSelf.bgImageView).offset(-18);
    }];
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bgImageView);
        make.trailing.equalTo(weakSelf.bgImageView).offset(-16);
    }];
}


- (void)setOrderTypeId:(NSString *)orderTypeId{
    _orderTypeId = orderTypeId;
    
//    if ([orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE]) {
//        self.addressName.text = @"收货地址:";
//    }else{
        self.addressName.text = @"公司名称:";
//    }
}

@end










