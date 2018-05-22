//
//  MuSpaceOrderInfoTableViewCell.m
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import "MuSpaceOrderInfoTableViewCell.h"
#import "UIColor+TPCategory.h"
#import "OrderHeader.h"
#import "Order.h"

@implementation MuSpaceOrderInfoTableViewCell

- (UILabel *)topLineView{
    
    if (_topLineView == nil) {
        _topLineView = [UILabel new];
        _topLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    
    return _topLineView;
}

- (UILabel *)middleLineView{
    
    if (_middleLineView == nil) {
        _middleLineView = [UILabel new];
        _middleLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    
    return _middleLineView;
}

/**
 *  Line
 *
 *  @return UILabel
 */
- (UILabel *)bottomLineView{
    
    if (_bottomLineView == nil) {
        _bottomLineView = [UILabel new];
        _bottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    
    return _bottomLineView;
}

/**
 *  订单时间（下单）
 *
 *  @return UILabel
 */
- (UILabel *)orderTime{
    
    if (_orderTime == nil) {
        _orderTime = [UILabel new];
        _orderTime.font = [UIFont systemFontOfSize:12.0f];
        _orderTime.textColor = [UIColor colorFromHexRGB:@"969696"];
    }
    
    return _orderTime;
}

/**
 *  订单号
 *
 *  @return UILabel
 */
- (UILabel *)orderId{
    
    if (_orderId == nil) {
        _orderId = [UILabel new];
        _orderId.font = [UIFont systemFontOfSize:12.0f];
        _orderId.textColor = [UIColor colorFromHexRGB:@"969696"];
    }
    
    return _orderId;
}

/**
 *  卖家
 *
 *  @return UILabel
 */
- (UILabel *)orderSale{
    
    if (_orderSale == nil) {
        _orderSale = [UILabel new];
        _orderSale.font = [UIFont systemFontOfSize:12.0f];
        _orderSale.textColor = [UIColor colorFromHexRGB:@"969696"];
    }
    
    return _orderSale;
}

- (UILabel *)remarkLabel {
    
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.font = [UIFont systemFontOfSize:12.0f];
        _remarkLabel.textColor = [UIColor colorFromHexRGB:@"969696"];
    }
    return _remarkLabel;
}

- (UITextView *)remarkValueLabel {
    
    if (!_remarkValueLabel) {
        _remarkValueLabel = [[UITextView alloc] init];
        _remarkValueLabel.font = [UIFont systemFontOfSize:12.0f];
        _remarkValueLabel.textColor = [UIColor colorFromHexRGB:@"969696"];
        _remarkValueLabel.layer.masksToBounds = YES;
        _remarkValueLabel.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _remarkValueLabel.layer.borderWidth = 0.5f;
        _remarkValueLabel.layer.cornerRadius = 4.0f;
        _remarkValueLabel.editable = NO;
    }
    return _remarkValueLabel;
}


#pragma mark -
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.topLineView];
        [self.contentView addSubview:self.middleLineView];
        [self.contentView addSubview:self.bottomLineView];
        
        [self.contentView addSubview:self.orderTime];
        [self.contentView addSubview:self.orderId];
        [self.contentView addSubview:self.orderSale];
        [self.contentView addSubview:self.remarkLabel];
        [self.contentView addSubview:self.remarkValueLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubviews];
    }
    
    
    
    
    
    return self;
    
}

- (void)setOrder:(Order *)order{
    
    _order = order;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    
    NSDateFormatter *dateFomatter2 = [NSDateFormatter new];
    [dateFomatter2 setDateFormat:@"yyyyMMddHHmmss"];
    
    self.orderTime.text = [NSString stringWithFormat:@"下单时间：%@",[dateFormatter stringFromDate:[dateFomatter2 dateFromString:order.orderHeader.orderDate]]];
    
    self.orderId.text = [NSString stringWithFormat:@"订单号：%@",order.orderHeader.orderId];
    
    self.orderSale.text = [NSString stringWithFormat:@"卖家：%@",order.orderHeader.storeName];
    
    self.remarkLabel.text = @"预约需求";
    self.remarkValueLabel.text = self.order.orderHeader.remark;
}


- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(18);
        make.leading.equalTo(weakSelf.contentView).offset(13);
    }];
    
    [self.orderId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderTime.mas_bottom).offset(10);
        make.leading.equalTo(weakSelf.orderTime);
    }];
    
    [self.orderSale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderId.mas_bottom).offset(10);
        make.leading.equalTo(weakSelf.orderTime);
    }];
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderSale.mas_bottom).offset(20);
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.middleLineView.mas_bottom).offset(20);
        make.leading.equalTo(weakSelf.orderTime);
    }];
    
    [self.remarkValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.remarkLabel.mas_bottom).offset(10.0f);
        make.width.equalTo(@(MainWidth - 36.0f));
        make.height.equalTo(@(90));
        make.leading.equalTo(weakSelf.orderTime);
    }];
}


#pragma mark -

//add by Thomas 换算时间以供显示－－－start
//转换时间显示
- (NSString *)dataTimeWith:(NSString *)str{
    if (![str isEqual:[NSNull null]] && str.length > 0) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
        
        NSDateFormatter *dateFomatter2 = [NSDateFormatter new];
        [dateFomatter2 setDateFormat:@"yyyyMMddHHmmss"];
        return  [dateFormatter stringFromDate:[dateFomatter2 dateFromString:str]];
    }
    return @"";
    
}

@end
