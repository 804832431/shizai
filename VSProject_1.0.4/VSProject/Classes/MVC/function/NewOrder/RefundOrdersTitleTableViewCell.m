//
//  RefundOrdersTitleTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RefundOrdersTitleTableViewCell.h"
#import "UIColor+TPCategory.h"
#import "OrderHeader.h"

@implementation RefundOrdersTitleTableViewCell


//- (UILabel *) topLineView{
//    
//    if (_topLineView == nil) {
//        _topLineView = [UILabel new];
//        _topLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
//        _topLineView.hidden = YES;
//    }
//    return _topLineView;
//}

- (UILabel *)orderId{
    
    if (_orderId == nil) {
        _orderId = [UILabel new];
        _orderId.font = [UIFont systemFontOfSize:12];
        _orderId.textColor =[UIColor colorFromHexRGB:@"343434"];
    }
    
    return _orderId;
}

- (UILabel *)orderStatus{
    
    if (_orderStatus == nil) {
        _orderStatus = [UILabel new];
        _orderStatus.font = [UIFont systemFontOfSize:10];
        _orderStatus.textColor =[UIColor colorFromHexRGB:@"ff6600"];
    }
    
    return _orderStatus;
}

//- (UILabel *) bottomLineView{
//    
//    if (_bottomLineView == nil) {
//        _bottomLineView = [UILabel new];
//        _bottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
//    }
//    
//    return _bottomLineView;
//}

#pragma mark -

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //        [self.contentView addSubview:self.topLineView];
        [self.contentView addSubview:self.orderStatus];
        [self.contentView addSubview:self.orderId];
        //        [self.contentView addSubview:self.bottomLineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        
        [self updateConstraintsForSubviews];
    }
    
    
    return self;
}

- (void)setOrder:(Order *)order{
    
    _order = order;
    
    self.orderId.text = [NSString stringWithFormat:@"订单编号：%@",order.orderHeader.orderId];
    //    //modify by Thomas ［O2O预约SALES_ORDER_O2O_SERVICE的ORDER_CREATED状态为预约中］－－－start
    //    NSString *orderType = order.orderHeader.orderTypeId;
    //    NSString *orderStatu = order.orderHeader.orderStatus;
    //    if ([orderType isEqualToString:SALES_ORDER_O2O_SERVICE]) {
    //        if ([orderStatu isEqualToString:ORDER_CREATED] || [orderStatu isEqualToString:ORDER_APPROVED]) {
    //            self.orderStatus.text =@"预约中";
    //        }else if([orderStatu isEqualToString:ORDER_PROCESSING]){
    //            self.orderStatus.text =@"商家已确认";
    //        }else if([orderStatu isEqualToString:ORDER_COMPLETED]){
    //            self.orderStatus.text =@"已完成";
    //        }else if([orderStatu isEqualToString:ORDER_CANCELLED]){
    //            self.orderStatus.text =@"已取消";
    //        }
    //        return;
    //    }
    //modify by Thomas ［O2O预约SALES_ORDER_O2O_SERVICE的ORDER_CREATED状态为预约中］－－－end
    
    
    if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY]) {
        /**
         * //O2O ,b2c订单初始状态
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_CREATED]) self.orderStatus.text =@"待支付";
        
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_CANCELLED]) self.orderStatus.text =@"已取消";
        /**
         *  020 （已支付）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_APPROVED]) self.orderStatus.text =@"待受理"; //
        /**
         * 商家接单(020) b2c已支付状态
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_PROCESSING]) self.orderStatus.text =@"已受理"; //
        
        /**
         * 取消成功
         */
        //    if([order.orderHeader.orderStatus isEqualToString: ORDER_CANCELLED]) self.orderStatus.text =@"订单关闭"; //
        /**
         * 已发货
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_SENT]) self.orderStatus.text =@"待服务"; //
        /**
         * 商家拒单
         */
        //    if([order.orderHeader.orderStatus isEqualToString: ORDER_REJECTED]) self.orderStatus.text =@"商家拒单"; //
        /**
         * 订单完成
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_COMPLETED]) self.orderStatus.text =@"已完成"; //
        /**
         * 申请退货（退款）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_RETURN_REQUESTED]) self.orderStatus.text =@"退款申请中"; //
        /**
         * 拒绝退货（退款）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_RETURN_MAN_REFUND]) self.orderStatus.text =@"拒绝退款"; //
        /**
         * 退款中（同意退款）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_RETURN_ACCEPTED]) self.orderStatus.text =@"同意退款"; //
        /**
         * 退货（退款）完成
         */
        if([order.orderHeader.orderStatus isEqualToString:SZ_RETURN_COMPLETED]) self.orderStatus.text =@"已退款";//
        
    }else{
        /**
         * //O2O ,b2c订单初始状态
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_CREATED]) self.orderStatus.text =@"待付款";
        
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_CANCELLED]) self.orderStatus.text =@"已取消";
        
        /**
         *  020 （已支付）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_APPROVED]) self.orderStatus.text =@"待发货"; //
        /**
         * 商家接单(020) b2c已支付状态
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_PROCESSING]) self.orderStatus.text =@"待发货"; //
        
        /**
         * 取消成功
         */
        //    if([order.orderHeader.orderStatus isEqualToString: ORDER_CANCELLED]) self.orderStatus.text =@"订单关闭"; //
        /**
         * 已发货
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_SENT]) self.orderStatus.text =@"待收货"; //
        /**
         * 商家拒单
         */
        //    if([order.orderHeader.orderStatus isEqualToString: ORDER_REJECTED]) self.orderStatus.text =@"商家拒单"; //
        /**
         * 订单完成
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_COMPLETED]) self.orderStatus.text =@"已完成"; //
        /**
         * 申请退货（退款）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_RETURN_REQUESTED]) self.orderStatus.text =@"退款申请中"; //
        /**
         * 拒绝退货（退款）
         */
        if([order.orderHeader.orderStatus isEqualToString: SZ_RETURN_MAN_REFUND]) self.orderStatus.text =@"拒绝退款"; //
        /**
         * 退款中（同意退款）
         */
        if([order.orderHeader.orderStatus isEqualToString: RETURN_ACCEPTED]) self.orderStatus.text =@"同意退款"; //
        /**
         * 退货（退款）完成
         */
        if([order.orderHeader.orderStatus isEqualToString:SZ_RETURN_COMPLETED]) self.orderStatus.text =@"已退款";//
    }
    
    if ([order.orderHeader.orderStatus isEqualToString:SZ_ORDER_COMPLETED]) {
        self.orderStatus.textColor = [UIColor colorFromHexRGB:@"8fc31fs"];
    }else if([order.orderHeader.orderStatus isEqualToString:SZ_RETURN_REQUESTED]||
             [order.orderHeader.orderStatus isEqualToString:SZ_RETURN_MAN_REFUND]||
             [order.orderHeader.orderStatus isEqualToString:RETURN_ACCEPTED]||
             [order.orderHeader.orderStatus isEqualToString:SZ_RETURN_COMPLETED] ){
        
        self.orderStatus.textColor = _Colorhex(0x2b9272);
    }
    
    else{
        self.orderStatus.textColor =[UIColor colorFromHexRGB:@"ff6600"];
    }
    
    
    
}


- (void) updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    //    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.leading.trailing.equalTo(weakSelf.contentView);
    //        make.height.mas_equalTo(RETINA_1PX);
    //    }];
    
    [self.orderId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(10);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    [self.orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.orderId);
        make.trailing.equalTo(weakSelf.contentView).offset(-10);
    }];
    
    //    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.trailing.bottom.equalTo(weakSelf.contentView);
    //        make.height.mas_equalTo(RETINA_1PX);
    //    }];
}
@end
