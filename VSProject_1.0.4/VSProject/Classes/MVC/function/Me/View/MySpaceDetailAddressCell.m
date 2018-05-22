//
//  MySpaceDetailAddressCell.m
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import "MySpaceDetailAddressCell.h"
#import "UIColor+TPCategory.h"
#import "OrderPostAddress.h"
#import "Order.h"

@implementation MySpaceDetailAddressCell

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

#pragma mark -

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView addSubview:self.contactImageView];
        [self.bgImageView addSubview:self.contactNameLabel];
        [self.bgImageView addSubview:self.phoneImageView];
        [self.bgImageView addSubview:self.phoneLabel];
        [self.bgImageView addSubview:self.contactName];
        
        [self updateConstraintsForSubViews];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    self.contactNameLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width/2 - 60;
    
    return self;
}


- (void)setOrder:(Order *)order{
    
    _order = order;
    
    NSString *contactNumber = nil;
    contactNumber = order.postAddress.contactNumber.length > 0?order.postAddress.contactNumber: @"       ";
    
    self.phoneLabel.text = contactNumber;
    self.contactNameLabel.text =  [NSString stringWithFormat:@"%@",order.postAddress.recipient.length > 0?order.postAddress.recipient:@"                    "];
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
        make.centerY.equalTo(weakSelf.contactImageView);
    }];
    
    [self.contactNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contactName.mas_trailing);
        make.top.equalTo(weakSelf.contactImageView).offset(-3);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/2 - 60);
    }];
    
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contactNameLabel.mas_trailing).offset(5);
        make.centerY.equalTo(weakSelf.contactImageView);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.phoneImageView.mas_trailing).offset(6);
        make.centerY.equalTo(weakSelf.phoneImageView);
        make.trailing.lessThanOrEqualTo(weakSelf.contentView).offset(-13);
    }];
    
}

@end
