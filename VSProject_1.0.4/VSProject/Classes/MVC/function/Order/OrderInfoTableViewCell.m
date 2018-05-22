//
//  OrderInfoTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "OrderInfoTableViewCell.h"
#import "UIColor+TPCategory.h"
#import "OrderHeader.h"


@implementation OrderInfoTableViewCell

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
 *  备注
 *
 *  @return UITextView
 */
- (UITextView *)messageTextView{
    
    if (_messageTextView == nil) {
        _messageTextView = [UITextView new];
        //        _messageTextView.layer.cornerRadius = 3;
        //        _messageTextView.layer.masksToBounds = YES;
        //        _messageTextView.layer.borderColor = [[UIColor colorFromHexRGB:@"dbdbdb"] CGColor];
        //        _messageTextView.layer.borderWidth = RETINA_1PX;
        _messageTextView.delegate = self;
        _messageTextView.textColor = [UIColor colorFromHexRGB:@"999999"];
        //        _messageTextView.text = @"备注：";
        _messageTextView.editable = NO;
        
    }
    
    return _messageTextView;
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
 *  配送时间
 *
 *  @return UILabel
 */
- (UILabel *)orderPastTime{
    
    if (_orderPastTime == nil) {
        _orderPastTime = [UILabel new];
        _orderPastTime.font = [UIFont systemFontOfSize:12.0f];
        _orderPastTime.textColor = [UIColor colorFromHexRGB:@"969696"];
    }
    
    return _orderPastTime;
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
 *  订单状态
 *
 *  @return UILabel
 */
- (UILabel *)orderStatus{
    
    if (_orderStatus == nil) {
        _orderStatus = [UILabel new];
        _orderStatus.font = [UIFont systemFontOfSize:12.0f];
        _orderStatus.textColor = [UIColor colorFromHexRGB:@"969696"];
    }
    
    return _orderStatus;
}

/**
 *  配送费
 *
 *  @return UILabel
 */
- (UILabel *)orderPastMoney{
    
    if (_orderPastMoney == nil) {
        _orderPastMoney = [UILabel new];
        _orderPastMoney.font = [UIFont systemFontOfSize:12.0f];
        _orderPastMoney.textColor = [UIColor colorFromHexRGB:@"969696"];
    }
    
    return _orderPastMoney;
}

/**
 *  优惠金额
 *
 *  @return UILabel
 */
- (UILabel *)orderDiscountAmount{
    
    if (_orderDiscountAmount == nil) {
        _orderDiscountAmount = [UILabel new];
        _orderDiscountAmount.font = [UIFont systemFontOfSize:12.0f];
        _orderDiscountAmount.textColor = [UIColor colorFromHexRGB:@"969696"];
    }
    
    return _orderDiscountAmount;
}

/**
 *  订单状态
 *
 *  @return UILabel
 */
- (UILabel *)orderMoney{
    
    if (_orderMoney == nil) {
        _orderMoney = [UILabel new];
        _orderMoney.font = [UIFont systemFontOfSize:12.0f];
        _orderMoney.textColor = [UIColor colorFromHexRGB:@"969696"];
    }
    
    return _orderMoney;
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

- (UILabel *)remarkTitleLabel{
    if (_remarkTitleLabel == nil) {
        _remarkTitleLabel = [UILabel new];
        _remarkTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        _remarkTitleLabel.textColor = [UIColor colorFromHexRGB:@"969696"];
    }
    return _remarkTitleLabel;
}



#pragma mark -
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.topLineView];
        [self.contentView addSubview:self.middleLineView];
        [self.contentView addSubview:self.bottomLineView];
        
        [self.contentView addSubview:self.orderTime];
        [self.contentView addSubview:self.orderPastTime];
        [self.contentView addSubview:self.orderId];
        [self.contentView addSubview:self.orderStatus];
        [self.contentView addSubview:self.orderPastMoney];
        [self.contentView addSubview:self.orderDiscountAmount];
        [self.contentView addSubview:self.orderMoney];
        [self.contentView addSubview:self.orderSale];
        [self.contentView addSubview:self.remarkTitleLabel];
        [self.contentView addSubview:self.messageTextView];
        
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
    self.orderPastMoney.text = [NSString stringWithFormat:@"配送费:¥ %@元",order.orderShippingTotal];
    self.orderDiscountAmount.text = [NSString stringWithFormat:@"优惠金额:¥ %.2f元",order.discountAmount.floatValue];
    
    double m_grandTotal = [order.orderHeader.grandTotal doubleValue];//	总价（支付）
    double m_discountAmount = [order.discountAmount doubleValue];//优惠
    NSString *m_orderTotal = [NSString stringWithFormat:@"%.2f",m_grandTotal + m_discountAmount];
    
    self.orderMoney.text = [NSString stringWithFormat:@"订单金额:¥ %@元",m_orderTotal];
    if ([order.orderHeader.storeName isEqual:[NSNull null]] || order.orderHeader.storeName == nil) {
        self.orderSale.text = @"卖家：";
    }
    else {
        self.orderSale.text = [NSString stringWithFormat:@"卖家：%@",order.orderHeader.storeName];
    }
    
    if ([self.order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE]) {
        self.remarkTitleLabel.text = @"备注:";
        
        [self.messageTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
        }];
    }else{
        self.remarkTitleLabel.text = @"需求表单:";
        
        
        [self.messageTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@100);
        }];
        
    }
    
    
    self.messageTextView.text = self.order.orderHeader.remark;
    
    if (self.order.orderHeader.remark == nil || self.order.orderHeader.remark.length == 0) {
        self.remarkTitleLabel.hidden = YES;
        self.messageTextView.hidden = YES;
    }
    
    __weak typeof(&*self) weakSelf = self;
    
    //    if (!([order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_B2C] || [order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_O2O_SERVICE_PAY])) {
    //        //Modify by Thomas O2O预约订单不显示备注－－－start
    //        self.orderPastTime.text = [NSString stringWithFormat:@"预约时间：%@",[self dataTimeWith:order.orderHeader.reservationDate]?:order.orderHeader.reservationDate];
    //        if ([order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_O2O_SERVICE]){
    //            self.messageTextView.hidden = YES;
    //            self.middleLineView.hidden = YES;
    //            self.orderSale.hidden = YES;
    //            self.orderMoney.hidden = YES;
    //            self.orderDiscountAmount.hidden = YES;
    //            self.orderPastMoney.text = [NSString stringWithFormat:@"商户：%@",order.orderHeader.storeName];
    //            //            [self.orderMoney mas_updateConstraints:^(MASConstraintMaker *make) {
    //            //                make.top.equalTo(weakSelf.orderPastMoney.mas_bottom).offset(10);
    //            //                make.leading.equalTo(weakSelf.orderTime);
    //            //            }];
    //            
    //        }else{
    //            self.messageTextView.hidden = NO;
    //            self.middleLineView.hidden = NO;
    //            self.orderSale.hidden = NO;
    //            self.orderMoney.hidden = NO;
    //            //Modify by Thomas O2O订单是“配送”－－－start
    //            self.orderPastTime.text = [NSString stringWithFormat:@"配送时间：%@",order.orderHeader.reservationDate];
    //            //Modify by Thomas O2O订单是“配送”－－－end
    //            self.messageTextView.text = order.orderHeader.remark.length > 0?order.orderHeader.remark:@"备注：";
    //            
    //        }
    //        //Modify by Thomas O2O预约订单不显示备注－－－end
    //        [self.orderStatus mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.top.equalTo(weakSelf.orderId.mas_bottom).offset(10);
    //            make.leading.equalTo(weakSelf.orderTime);
    //            make.height.mas_equalTo(0).priority(MASLayoutPriorityRequired);
    //        }];
    //        
    //        [self.orderPastMoney mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.top.equalTo(weakSelf.orderId.mas_bottom).offset(10);
    //            make.leading.equalTo(weakSelf.orderTime);
    //        }];
    //        
    //        
    //    }else{
    //    self.messageTextView.text = order.orderHeader.remark.length > 0?order.orderHeader.remark:@"备注：";
    //    [self.orderPastTime mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(weakSelf.orderTime.mas_bottom).offset(10);
    //        make.leading.equalTo(weakSelf.orderTime);
    //        make.height.mas_equalTo(0);
    //    }];
    //    
    //    [self.orderId mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(weakSelf.orderTime.mas_bottom).offset(10);
    //        make.leading.equalTo(weakSelf.orderTime);
    //    }];
    
    if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY]) {
        /**
         * //O2O ,b2c订单初始状态
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_CREATED]) self.orderStatus.text =@"订单状态:待支付";
        /**
         *  020 （已支付）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_APPROVED]) self.orderStatus.text =@"订单状态:待受理"; //
        /**
         * 商家接单(020) b2c已支付状态
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_PROCESSING]) self.orderStatus.text =@"订单状态:已受理"; //
        
        /**
         * 取消成功
         */
        //    if([order.orderHeader.orderStatus isEqualToString: ORDER_CANCELLED]) self.orderStatus.text =@"订单关闭"; //
        /**
         * 已发货
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_SENT]) self.orderStatus.text =@"订单状态:待服务"; //
        /**
         * 商家拒单
         */
        //    if([order.orderHeader.orderStatus isEqualToString: ORDER_REJECTED]) self.orderStatus.text =@"商家拒单"; //
        /**
         * 订单完成
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_COMPLETED]) self.orderStatus.text =@"订单状态:已完成"; //
        /**
         * 申请退货（退款）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_RETURN_REQUESTED]) self.orderStatus.text =@"订单状态:退款中"; //
        /**
         * 拒绝退货（退款）
         */
        //    if([order.orderHeader.orderStatus isEqualToString: RETURN_MAN_REFUND]) self.orderStatus.text =@"拒绝退货(退款)"; //
        /**
         * 退款中（同意退款）
         */
        //    if([order.orderHeader.orderStatus isEqualToString: RETURN_ACCEPTED]) self.orderStatus.text =@"退款中"; //
        /**
         * 退货（退款）完成
         */
        if([order.orderHeader.orderStatus isEqualToString:SZ_RETURN_COMPLETED]) self.orderStatus.text =@"订单状态:已关闭";//
        
    }else{
        /**
         * //O2O ,b2c订单初始状态
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_CREATED]) self.orderStatus.text =@"订单状态:待付款";
        /**
         *  020 （已支付）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_APPROVED]) self.orderStatus.text =@"订单状态:待发货"; //
        /**
         * 商家接单(020) b2c已支付状态
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_PROCESSING]) self.orderStatus.text =@"订单状态:待发货"; //
        
        /**
         * 取消成功
         */
        //    if([order.orderHeader.orderStatus isEqualToString: ORDER_CANCELLED]) self.orderStatus.text =@"订单关闭"; //
        /**
         * 已发货
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_SENT]) self.orderStatus.text =@"订单状态:待收货"; //
        /**
         * 商家拒单
         */
        //    if([order.orderHeader.orderStatus isEqualToString: ORDER_REJECTED]) self.orderStatus.text =@"商家拒单"; //
        /**
         * 订单完成
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_COMPLETED]) self.orderStatus.text =@"订单状态:已完成"; //
        /**
         * 申请退货（退款）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_RETURN_REQUESTED]) self.orderStatus.text =@"订单状态:退款中"; //
        /**
         * 拒绝退货（退款）
         */
        //    if([order.orderHeader.orderStatus isEqualToString: RETURN_MAN_REFUND]) self.orderStatus.text =@"拒绝退货(退款)"; //
        /**
         * 退款中（同意退款）
         */
        //    if([order.orderHeader.orderStatus isEqualToString: RETURN_ACCEPTED]) self.orderStatus.text =@"退款中"; //
        /**
         * 退货（退款）完成
         */
        if([order.orderHeader.orderStatus isEqualToString:SZ_RETURN_COMPLETED]) self.orderStatus.text =@"订单状态:已关闭";//
    }
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
    
    [self.orderPastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderTime.mas_bottom).offset(0);
        make.leading.equalTo(weakSelf.orderTime);
        make.height.equalTo(@0);
    }];
    
    [self.orderId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderPastTime.mas_bottom).offset(10);
        make.leading.equalTo(weakSelf.orderTime);
    }];
    
    [self.orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderId.mas_bottom).offset(10);
        make.leading.equalTo(weakSelf.orderTime);
    }];
    
    [self.orderPastMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderStatus.mas_bottom).offset(10);
        make.leading.equalTo(weakSelf.orderTime);
    }];
    
    [self.orderDiscountAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderPastMoney.mas_bottom).offset(10);
        make.leading.equalTo(weakSelf.orderTime);
    }];
    
    [self.orderMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderDiscountAmount.mas_bottom).offset(10);
        make.leading.equalTo(weakSelf.orderTime);
    }];
    
    [self.orderSale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderMoney.mas_bottom).offset(10);
        make.leading.equalTo(weakSelf.orderTime);
    }];
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderSale.mas_bottom).offset(20);
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.remarkTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.messageTextView).offset(8);
        make.leading.equalTo(weakSelf.contentView).offset(16);
    }];
    
    [self.messageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.remarkTitleLabel.mas_trailing).offset(6);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        make.top.equalTo(weakSelf.middleLineView.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
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
//add by Thomas 换算时间以供显示－－－end
@end
