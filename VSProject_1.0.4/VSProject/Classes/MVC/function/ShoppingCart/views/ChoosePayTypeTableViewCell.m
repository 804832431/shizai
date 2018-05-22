//
//  choosePayTypeTableViewCell.m
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import "ChoosePayTypeTableViewCell.h"
#import "UIColor+TPCategory.h"


@implementation ChoosePayTypeTableViewCell

- (UILabel *) topLineView{
    
    if (_topLineView == nil) {
        _topLineView = [UILabel new];
        _topLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    return _topLineView;
}

- (UILabel *)payType{
    
    if (_payType == nil) {
        _payType = [UILabel new];
        _payType.font = [UIFont systemFontOfSize:12];
        _payType.textColor = [UIColor colorFromHexRGB:@"999999"];
        _payType.text = @"付款方式:";
    }
    
    return _payType;
}


- (UILabel *)payTypeValue{
    
    if (_payTypeValue == nil) {
        _payTypeValue = [UILabel new];
        _payTypeValue.font = [UIFont systemFontOfSize:12];
        _payTypeValue.textColor = [UIColor colorFromHexRGB:@"999999"];
        _payTypeValue.text = @"在线支付";
    }
    
    return _payTypeValue;
}

- (UILabel *) bottomLineView{
    
    if (_bottomLineView == nil) {
        _bottomLineView = [UILabel new];
        _bottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    return _bottomLineView;
}

#pragma mark -

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        [self.contentView addSubview:self.topLineView];
        [self.contentView addSubview:self.payType];
        [self.contentView addSubview:self.payTypeValue];
        [self.contentView addSubview:self.bottomLineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubviews];
    }
    
    return self;
}

- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.payType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    [self.payTypeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
}

@end
