//
//  RefundOrdersTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RefundOrdersProductTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation RefundOrdersProductTableViewCell


- (UIImageView *)productImageView{
    
    if (_productImageView == nil) {
        _productImageView = [UIImageView new];
        
        //        _productImageView.layer.masksToBounds = YES;
        //        _productImageView.layer.cornerRadius = 6;
        //        _productImageView.layer.borderColor = [[UIColor colorFromHexRGB:@"dbdbdb"] CGColor];
        //        _productImageView.layer.borderWidth = 1;
    }
    
    return _productImageView;
}

- (UILabel *)productName{
    
    if (_productName == nil) {
        _productName = [UILabel new];
        _productName.font = [UIFont systemFontOfSize:15];
        _productName.textColor = [UIColor colorFromHexRGB:@"343434"];
    }
    
    return _productName;
}


- (UILabel *)storeName{
    if (_storeName == nil) {
        _storeName = [UILabel new];
        _storeName.font = [UIFont systemFontOfSize:12];
        _storeName.textColor = [UIColor colorFromHexRGB:@"343434"];
    }
    return _storeName;
}

- (UILabel *)orderTime{
    if (_orderTime == nil) {
        _orderTime = [UILabel new];
        _orderTime.font = [UIFont systemFontOfSize:10];
        _orderTime.textColor = [UIColor colorFromHexRGB:@"7c7c7c"];
    }
    return _orderTime;
}

- (UILabel *)orderPrice{
    if (_orderPrice == nil) {
        _orderPrice = [UILabel new];
        _orderPrice.font = [UIFont systemFontOfSize:13];
        _orderPrice.textColor = [UIColor colorFromHexRGB:@"343434"];
    }
    return _orderPrice;
}

- (UILabel *)outOrderPrice{
    if (_outOrderPrice == nil) {
        _outOrderPrice = [UILabel new];
        _outOrderPrice.font = [UIFont systemFontOfSize:13];
        
    }
    return _outOrderPrice;
}



#pragma mark -

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.productName];
        [self.contentView addSubview:self.productImageView];
        [self.contentView addSubview:self.orderPrice];
        [self.contentView addSubview:self.outOrderPrice];
        [self.contentView addSubview:self.orderTime];
        [self.contentView addSubview:self.storeName];
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        
        [self updateConstraintsForSubviews];
    }
    
    return self;
}


- (void)setOrder:(Order *)order{
    
    _order = order;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    if (self.order == nil) {
        return;
    }
    
    Order *order = self.order;
    
    OrderProduct *orderProduct = order.orderProductList.firstObject;
    
    self.productName.text = orderProduct.productName;
    
    self.storeName.text = order.orderHeader.storeName;
    
    NSString *orderTime = order.orderHeader.orderDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [formatter dateFromString:orderTime];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *orderDate = [formatter stringFromDate:date];
    
    self.orderTime.text = orderDate;
    
    self.orderPrice.text = [NSString stringWithFormat:@"交易金额:¥%@",order.orderHeader.grandTotal];
    
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退款金额:¥%@",order.orderHeader.refundAmount ]];
    [mStr setAttributes:@{NSForegroundColorAttributeName:_Colorhex(0xf6504f)} range:NSMakeRange(5, mStr.length - 5)];
    
    self.outOrderPrice.attributedText = mStr;
    
    [self.productImageView sd_setImageWithString:[NSString stringWithFormat:@"%@",orderProduct.smallImageUrl] placeholderImage:[UIImage  imageNamed:@"usercenter_defaultpic"]];
}

- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(10);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.height.mas_equalTo(80);
    }];
    
    [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productImageView.mas_trailing).offset(13);
        make.top.equalTo(weakSelf.productImageView).offset(5);
        make.trailing.equalTo(weakSelf.contentView).offset(-10);
    }];
    
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productName);
        make.top.equalTo(weakSelf.productName.mas_bottom).offset(4);
        make.trailing.equalTo(weakSelf.productName);
        make.height.equalTo(@15);
    }];
    
    
    [self.orderPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productName);
        make.bottom.equalTo(weakSelf.productImageView);
    }];
    
    [self.outOrderPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.productImageView);
        make.trailing.equalTo(weakSelf.contentView).offset(-10);
    }];
    
    [self.orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.contentView).offset(-10);
        make.bottom.equalTo(weakSelf.outOrderPrice.mas_top).offset(-8);
    }];
    
    
}


@end































