//
//  OrderRefundReasonTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 15/12/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "OrderRefundReasonTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation OrderRefundReasonTableViewCell

- (UILabel *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [UILabel new];
        _bottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    
    return _bottomLineView;
}

- (UILabel *)TopLineView{
    if (_TopLineView == nil) {
        _TopLineView = [UILabel new];
        _TopLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    
    return _TopLineView;
}



- (UILabel *)refundResonName{
    
    if (_refundResonName == nil) {
        
        _refundResonName = [UILabel new];
        
        _refundResonName.font = [UIFont systemFontOfSize:12.0f];
        
        _refundResonName.textColor = [UIColor colorFromHexRGB:@"969696"];
        
        
    }
    
    return _refundResonName;
}

- (UILabel *)refundResonValue{
    
    if (_refundResonValue == nil) {
        
        _refundResonValue = [UILabel new];
        
        _refundResonValue.font = [UIFont systemFontOfSize:12.0f];
        
        _refundResonValue.textColor = [UIColor colorFromHexRGB:@"969696"];
        
        _refundResonValue.numberOfLines = 0;
    }
    
    return _refundResonValue;
}
#pragma mark -

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.TopLineView];
        [self.contentView addSubview:self.refundResonName];
        [self.contentView addSubview:self.refundResonValue];
        [self.contentView addSubview:self.bottomLineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubviews];
    }
    self.refundResonValue.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 32 - 60;
    
    return self;
}


- (void)setOrder:(Order *)order{
    
    _order = order;
    
    self.refundResonName.text = @"退款原因:";
    self.refundResonValue.text = self.order.returnReason;
    
}

- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    self.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 99999);
    
    [self.TopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.refundResonName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.top.equalTo(weakSelf.TopLineView.mas_bottom).offset(10);
        make.width.lessThanOrEqualTo(@60);
    }];
    
    [self.refundResonValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.refundResonName.mas_trailing);
        make.top.equalTo(weakSelf.TopLineView.mas_bottom).offset(10);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        
    }];
    
    
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.refundResonValue.mas_bottom).offset(10);
        make.leading.trailing.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
}


#pragma mark -


@end
