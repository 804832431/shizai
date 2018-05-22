//
//  chooseSendTimeTableViewCell.m
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import "ChooseSendTimeTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation ChooseSendTimeTableViewCell

- (UILabel *) topLineView{
    
    if (_topLineView == nil) {
        _topLineView = [UILabel new];
        _topLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    return _topLineView;
}

- (UILabel *)sendTime{
    
    if (_sendTime == nil) {
        _sendTime = [UILabel new];
        _sendTime.font = [UIFont systemFontOfSize:12];
        _sendTime.textColor = [UIColor colorFromHexRGB:@"999999"];
        _sendTime.text = @"配送时间:";
    }
    
    return _sendTime;
}


- (UILabel *)sendTimeValue{
    
    if (_sendTimeValue == nil) {
        _sendTimeValue = [UILabel new];
        _sendTimeValue.font = [UIFont systemFontOfSize:12];
        _sendTimeValue.textColor = [UIColor colorFromHexRGB:@"999999"];
        _sendTimeValue.text = @"请选择";
    }
    
    return _sendTimeValue;
}

- (UIImageView *)detailImageView{
    
    if (_detailImageView == nil) {
        _detailImageView = [UIImageView new];
        _detailImageView.image = [UIImage imageNamed:@"修改"];
    }
    
    return _detailImageView;
}

#pragma mark -

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        [self.contentView addSubview:self.topLineView];
        [self.contentView addSubview:self.sendTime];
        [self.contentView addSubview:self.sendTimeValue];
        [self.contentView addSubview:self.detailImageView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubviews];
    }
    
    return self;
}

- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    
    [self.sendTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        
    }];
    
    [self.sendTimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.trailing.equalTo(weakSelf.detailImageView.mas_leading).offset(-5);
    }];
    
}

@end








