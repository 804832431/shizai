//
//  NewCenterCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/29.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NewCenterCell.h"

@implementation NewCenterCell

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = _Colorhex(0xdedede);
    }
    return _bottomLineView;
}

- (UIImageView *)flagImageView{
    if (_flagImageView == nil) {
        _flagImageView = [[UIImageView alloc] init];
        _flagImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _flagImageView;
}

- (UILabel *)contentTitleLabel{
    if (_contentTitleLabel == nil) {
        _contentTitleLabel = [[UILabel alloc] init];
        _contentTitleLabel.font = [UIFont systemFontOfSize:16];
        _contentTitleLabel.textColor = _Colorhex(0x282828);
    }
    return _contentTitleLabel;
}

- (UILabel *)contentDescLabel{
    if (_contentDescLabel == nil) {
        _contentDescLabel = [UILabel new];
        _contentDescLabel.font = [UIFont systemFontOfSize:16];
        _contentDescLabel.textColor = _Colorhex(0xa2a2a2);
    }
    return _contentDescLabel;
}

- (UIImageView *)detailImageView{
    if (_detailImageView == nil) {
        _detailImageView = [[UIImageView alloc] init];
        _detailImageView.image = [UIImage imageNamed:@"订单中心－更多－icon"];
    }
    return _detailImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.flagImageView];
        [self.contentView addSubview:self.contentTitleLabel];
        [self.contentView addSubview:self.contentDescLabel];
        [self.contentView addSubview:self.detailImageView];
        [self.contentView addSubview:self.bottomLineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubViews];
    }
    return self;
}

- (void)updateConstraintsForSubViews{
    __weak typeof(self) weakSelf  = self;
    
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.contentView).offset(12);
    }];
    
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.flagImageView.mas_trailing).offset(22);
    }];
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.trailing.equalTo(weakSelf.contentView).offset(-12);
    }];
    
    [self.contentDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.trailing.equalTo(weakSelf.detailImageView.mas_leading).offset(-15);
    }];
    
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(weakSelf.contentView);
        make.height.equalTo(@0.5);
    }];
    
    
}

@end












