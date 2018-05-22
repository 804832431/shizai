//
//  OrderBottomView.m
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import "OrderBottomView.h"
#import "UIColor+TPCategory.h"
@implementation OrderBottomView

-(UILabel *)totalLabel{
    
    if (_totalLabel == nil) {
        _totalLabel = [UILabel new];
        _totalLabel.textColor = [UIColor whiteColor];
        _totalLabel.font = [UIFont systemFontOfSize:15];
        _totalLabel.text = @"合计：";
    }
    
    return _totalLabel;
}

- (UILabel *)totalMoney{
    
    if (_totalMoney == nil) {
        _totalMoney = [UILabel new];
        _totalMoney.textColor = [UIColor whiteColor];
        _totalMoney.font = [UIFont systemFontOfSize:15];
    }
    
    return _totalMoney;
}

- (UIButton *)okButton{
    
    if (_okButton == nil) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okButton setBackgroundColor:[UIColor colorFromHexRGB:@"f15353"]];
        _okButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_okButton setTitle:@"去结算" forState:UIControlStateNormal];
        [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_okButton addTarget:self action:@selector(okButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _okButton;
}

- (void)okButtonAction{
    if (self.goToPayBlock) {
        self.goToPayBlock();
    }
}

#pragma mark -

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor colorFromHexRGB:@"303131"];
        [self addSubview:self.totalLabel];
        [self addSubview:self.totalMoney];
        [self addSubview:self.okButton];
        [self updateConstraintsForSubviews];
    }
    
    self.totalMoney.text = @"$100.3";
    
    return self;
}


- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.leading.equalTo(weakSelf).offset(16);
    }];
    
    [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.totalLabel);
        make.leading.equalTo(weakSelf.totalLabel.mas_trailing).offset(6);
    }];
    
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.top.equalTo(weakSelf);
        make.width.mas_equalTo(135);
    }];
    
}



@end











