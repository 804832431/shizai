//
//  EvaluateOrderInfoCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "EvaluateOrderInfoCell.h"
#import "Order.h"

@implementation EvaluateOrderInfoCell

-  (UILabel *)orderIdLabel{
    if (_orderIdLabel == nil) {
        _orderIdLabel = [UILabel new];
        _orderIdLabel.font = [UIFont systemFontOfSize:14];
        _orderIdLabel.textColor = _Colorhex(0x494949);
    }
    return _orderIdLabel;
}

-  (UILabel *)orderCompanyLabel{
    if (_orderCompanyLabel == nil) {
        _orderCompanyLabel = [UILabel new];
        _orderCompanyLabel.font = [UIFont systemFontOfSize:14];
        _orderCompanyLabel.textColor = _Colorhex(0x494949);
    }
    return _orderCompanyLabel;
}

-  (UILabel *)orderStateLabel{
    if (_orderStateLabel == nil) {
        _orderStateLabel = [UILabel new];
        _orderStateLabel.font = [UIFont systemFontOfSize:14];
        _orderStateLabel.textColor = _Colorhex(0x494949);
    }
    return _orderStateLabel;
}

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = _Colorhex(0xdedede);
    }
    return _bottomLineView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.orderIdLabel];
        [self.contentView addSubview:self.orderCompanyLabel];
        [self.contentView addSubview:self.orderStateLabel];
        
        [self.contentView addSubview:self.bottomLineView];
        
        [self updateConstraintsForSubViews];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    
    
    return self;
}


- (void)setOrder:(Order *)order{
    _order = order;
    
    
    self.orderIdLabel.text = [NSString stringWithFormat: @"订单号:%@", order.orderHeader.orderId];
    self.orderCompanyLabel.text = [NSString stringWithFormat:@"服务供应商名称:%@",order.orderHeader.storeName];
    self.orderStateLabel.text = [NSString stringWithFormat:@"订单状态:待评价"];
}

- (void)updateConstraintsForSubViews{
    
    __weak typeof(self) weakSelf = self;
    
    [self.orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(12);
        make.trailing.equalTo(weakSelf.contentView).offset(-12);
        make.top.equalTo(weakSelf.contentView).offset(15);
    }];
    
    [self.orderCompanyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(12);
        make.trailing.equalTo(weakSelf.contentView).offset(-12);
        make.top.equalTo(weakSelf.orderIdLabel.mas_bottom).offset(8);
    }];
    
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(12);
        make.trailing.equalTo(weakSelf.contentView).offset(-12);
        make.top.equalTo(weakSelf.orderCompanyLabel.mas_bottom).offset(8);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(@0.5);
    }];
}


@end













