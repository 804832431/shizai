//
//  RequestBackDepositTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/11/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RequestBackDepositTableViewCell.h"
#import "Masonry.h"

@implementation RequestBackDepositTableViewCell

- (UIView *)contentBackgroundView{
    if (_contentBackgroundView == nil) {
        _contentBackgroundView = [UIView new];
        _contentBackgroundView.backgroundColor = _Colorhex(0xfbfbfb);
        _contentBackgroundView.layer.cornerRadius = 4;
        _contentBackgroundView.layer.masksToBounds = YES;
    }
    return _contentBackgroundView;
}

- (UIView *)bottomContentBackgroundView{
    if (_bottomContentBackgroundView == nil) {
        _bottomContentBackgroundView = [UIView new];
        _bottomContentBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomContentBackgroundView;
}
- (UIView *)topLieView{
    if (_topLieView == nil) {
        _topLieView = [UIView new];
        _topLieView.backgroundColor = _Colorhex(0xdbdbdb);
    }
    return _topLieView;
}

- (UILabel *)bidDespoitCallbackStatusLabel{
    if (_bidDespoitCallbackStatusLabel == nil) {
        _bidDespoitCallbackStatusLabel = [UILabel new];
        _bidDespoitCallbackStatusLabel.font = [UIFont systemFontOfSize:11];
        _bidDespoitCallbackStatusLabel.textColor = _Colorhex(0x2f9f7e);
    }
    return _bidDespoitCallbackStatusLabel;
}


- (UILabel *)bidNameLabel{
    if (_bidNameLabel == nil) {
        _bidNameLabel = [UILabel new];
        _bidNameLabel.font = [UIFont systemFontOfSize:15];
        _bidNameLabel.textColor = _Colorhex(0x333333);
        _bidNameLabel.numberOfLines = 0;
    }
    return _bidNameLabel;
}

- (UILabel *)bidDespoitLabel{
    if (_bidDespoitLabel == nil) {
        _bidDespoitLabel = [UILabel new];
        _bidDespoitLabel.textColor = _Colorhex(0xcc9a9a9a);
        _bidDespoitLabel.font = [UIFont systemFontOfSize:11];
    }
    return _bidDespoitLabel;
}

- (UILabel *)payTitleLabel{
    if (_payTitleLabel == nil) {
        _payTitleLabel = [UILabel new];
        _payTitleLabel.font = [UIFont systemFontOfSize:11];
        _payTitleLabel.textColor = _Colorhex(0xcc000000);
    }
    return _payTitleLabel;
}

- (UILabel *)payLabel{
    if (_payLabel == nil) {
        _payLabel = [UILabel new];
        _payLabel.font = [UIFont systemFontOfSize:11];
        _payLabel.textColor = _Colorhex(0xccff0000);
    }
    return _payLabel;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = _Colorhex(0xf4f4f4);
        
        [self.contentView addSubview:self.contentBackgroundView];
        [self.contentBackgroundView addSubview:self.bottomContentBackgroundView];
        
        [self.contentBackgroundView addSubview:self.topLieView];
        [self.contentBackgroundView addSubview:self.bidDespoitCallbackStatusLabel];
        [self.contentBackgroundView addSubview:self.bidNameLabel];
        
        [self.bottomContentBackgroundView addSubview:self.bidDespoitLabel];
        [self.bottomContentBackgroundView addSubview:self.payTitleLabel];
        [self.bottomContentBackgroundView addSubview:self.payLabel];
        self.bidNameLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 40;
        
        
        [self updateConstraintsForSubViews];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return self;
}

- (void)updateConstraintsForSubViews{
    
    __weak typeof(self) weakSelf = self;
    [self.contentBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.contentView).offset(10);
        make.trailing.equalTo(weakSelf.contentView).offset(-10);
    }];
    
    [self.bidDespoitCallbackStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.contentBackgroundView).offset(-10);
        make.top.equalTo(weakSelf.contentBackgroundView).offset(7.5);
    }];
    
    [self.topLieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.contentBackgroundView);
        make.top.equalTo(weakSelf.contentBackgroundView).offset(26);
        make.height.equalTo(@0.5);
    }];
    
    [self.bidNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentBackgroundView).offset(10);
        make.trailing.equalTo(weakSelf.contentBackgroundView).offset(-10);
        make.top.equalTo(weakSelf.topLieView.mas_bottom).offset(16);
    }];
    
    [self.bottomContentBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(weakSelf.contentBackgroundView);
        make.height.equalTo(@35);
        make.top.equalTo(weakSelf.bidNameLabel.mas_bottom).offset(16);
    }];
    
    [self.bidDespoitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bottomContentBackgroundView);
        make.leading.equalTo(weakSelf.bottomContentBackgroundView).offset(10);
    }];
    
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bottomContentBackgroundView);
        make.trailing.equalTo(weakSelf.bottomContentBackgroundView).offset(-10);
    }];
    
    [self.payTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bottomContentBackgroundView);
        make.trailing.equalTo(weakSelf.payLabel.mas_leading);
    }];
}

- (void)setDto:(BidProject *)dto{
    _dto = dto;
    
//    退款申请中：RETURN_REQUESTED；
//    已同意：RETURN_ACCEPTED，
//    已退款：RETURN_COMPLETED
    
    
    if ([dto.returnStatus isEqualToString:@"RETURN_REQUESTED"]) {
        self.bidDespoitCallbackStatusLabel.text = @"申请中";
    }else if ([dto.returnStatus isEqualToString:@"RETURN_ACCEPTED"]) {
        self.bidDespoitCallbackStatusLabel.text = @"已受理";
    }else if ([dto.returnStatus isEqualToString:@"RETURN_COMPLETED"]) {
        self.bidDespoitCallbackStatusLabel.text = @"已退款";
    }
    
    self.bidNameLabel.text = dto.projectName;
    
    self.bidDespoitLabel.text = [NSString stringWithFormat:@"保证金额:%@元",dto.bidDeposit];
    
    self.payTitleLabel.text = @"退款金额：";
    self.payLabel.text = [NSString stringWithFormat:@"%@元",dto.bidDeposit];

}

@end
