//
//  O2OOrderOperationTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "O2OOrderOperationTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation O2OOrderOperationTableViewCell

- (UILabel *)sepLineView{
    
    if (_sepLineView == nil) {
        _sepLineView = [UILabel new];
        _sepLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
        
    }
    
    return _sepLineView;
    
}

- (UILabel *)orderNeedMoney{
    
    if (_orderNeedMoney == nil) {
        _orderNeedMoney = [UILabel new];
        _orderNeedMoney.textColor = [UIColor colorFromHexRGB:@"35b38d"];
        _orderNeedMoney.font = [UIFont systemFontOfSize:12];
    }
    
    return _orderNeedMoney;
}

- (UILabel *)orderNeedMoneyTitle{
    
    if (_orderNeedMoneyTitle == nil) {
        _orderNeedMoneyTitle = [UILabel new];
        _orderNeedMoneyTitle.textColor = [UIColor colorFromHexRGB:@"999999"];
        _orderNeedMoneyTitle.font = [UIFont systemFontOfSize:12];
    }
    
    return _orderNeedMoneyTitle;
    
}

- (UILabel *)orderStatus{
    
    if (_orderStatus == nil) {
        
        _orderStatus = [UILabel new];
        _orderStatus.textColor = [UIColor colorFromHexRGB:@"ff6600"];
        _orderStatus.font = [UIFont systemFontOfSize:12];
        
    }
    
    return _orderStatus;
}

//- (UIButton *)OpButton{
//    
//    if (_OpButton == nil) {
//        _OpButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_OpButton setTitle:@"退款" forState:UIControlStateNormal];
//        [_OpButton setTitleColor:[UIColor colorFromHexRGB:@"35b38d"] forState:UIControlStateNormal];
//        _OpButton.layer.masksToBounds = YES;
//        _OpButton.layer.cornerRadius = 5;
//        _OpButton.layer.borderColor = [[UIColor colorFromHexRGB:@"35b38d"]CGColor];
//        _OpButton.layer.borderWidth = 1;
//        _OpButton.titleLabel.font = [UIFont systemFontOfSize:12];
//    }
//    return _OpButton;
//}

- (UIButton *)oneButton{
    
    if (_oneButton == nil) {
        _oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_oneButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
        //        _oneButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
        _oneButton.layer.masksToBounds = YES;
        _oneButton.layer.cornerRadius = 3;
        //
        //        _oneButton.layer.borderWidth = 0.5;
        _oneButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_oneButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _oneButton;
}


- (UIButton *)twoButton{
    
    if (_twoButton == nil) {
        _twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_twoButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
        //        _twoButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
        _twoButton.layer.masksToBounds = YES;
        _twoButton.layer.cornerRadius = 3;
        //
        //        _twoButton.layer.borderWidth = 0.5;
        _twoButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_twoButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _twoButton;
}

- (UIButton *)threeButton{
    
    if (_threeButton == nil) {
        _threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_threeButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
        //        _threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"ff6600"]CGColor];
        _threeButton.layer.masksToBounds = YES;
        _threeButton.layer.cornerRadius = 3;
        //        _threeButton.layer.borderWidth = 0.5;
        _threeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_threeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _threeButton;
}

- (void)buttonAction:(UIButton *)button{
    
    NSString *title = [button currentTitle];
    //    //Modify by Thomas[增加取消预约:订单状态ORDER_CREATED订单类型SALES_ORDER_O2O_SERVICE]---start
    //    if ([title  isEqualToString:@"取消预约"]) {
    //        
    //        if (self.cancelAppointment) {
    //            self.cancelAppointment(self.order);
    //        }
    //        
    //    }else
    //        //Modify by Thomas[增加取消预约:订单状态ORDER_CREATED订单类型SALES_ORDER_O2O_SERVICE]---end
    //        //Modify by Thomas[增加买单:订单状态ORDER_PROCESSING订单类型SALES_ORDER_O2O_SERVICE]---start
    //        if ([title  isEqualToString:@"买单"]) {
    //            
    //            if (self.readyPayOrder) {
    //                self.readyPayOrder(self.order);
    //            }
    //            
    //        }else
    //            //Modify by Thomas[增加买单:订单状态ORDER_PROCESSING订单类型SALES_ORDER_O2O_SERVICE]---end
    
    if ([title  isEqualToString:@"取消订单"]) {
        
        if (self.cancelOrder) {
            self.cancelOrder(self.order);
        }
        
    }else if ([title  isEqualToString:@"付款"]|[title  isEqualToString:@"去支付"]) {
        
        if (self.payOrder) {
            self.payOrder(self.order);
        }
    }else if ([title  isEqualToString:@"退款/退货"]||[title  isEqualToString:@"申请退款"]) {
        
        if (self.refundRrder) {
            self.refundRrder(self.order);
        }
        
    }else if ([title  isEqualToString:@"查看物流"]) {
        
        if (self.showPostInfo) {
            self.showPostInfo(self.order);
        }
        
    }else if ([title  isEqualToString:@"确认收货"]) {
        if (self.confirmReceiptOrder) {
            self.confirmReceiptOrder(self.order);
        }
    }else if ([title  isEqualToString:@"去评价"]) {
        if (self.evaluateOrder) {
            self.evaluateOrder(self.order);
        }
    }else if ([title isEqualToString:@"发票申请"]) {
        if (self.applyInvoice) {
            self.applyInvoice(self.order);
        }
    }
}

- ( UILabel *)bottomLineView{
    
    if (_bottomLineView == nil) {
        _bottomLineView = [UILabel new];
        _bottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
        
    }
    
    return _bottomLineView;
}


#pragma mark -

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.orderNeedMoneyTitle];
        [self.contentView addSubview:self.orderNeedMoney];
        [self.contentView addSubview:self.orderStatus];
        //        [self.contentView addSubview:self.OpButton];
        [self.contentView addSubview:self.oneButton];
        [self.contentView addSubview:self.twoButton];
        [self.contentView addSubview:self.threeButton];
        [self.contentView addSubview:self.sepLineView];
        [self.contentView addSubview:self.bottomLineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubviews];
    }
    
    self.orderNeedMoneyTitle.text = @"实付金额:";
    
    
    return self;
}

- (void)setOrder:(Order *)order{
    
    _order = order;
    
    self.orderNeedMoney.text = [NSString stringWithFormat:@"¥ %@",order.orderHeader.grandTotal];
    //    //modify by Thomas O2O订单详情里面不展示实际支付金额（修改控件约束）－－－start
    //    if ([order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_O2O_SERVICE]){
    //        __weak typeof(&*self) weakSelf = self;
    //        if ([order.payDate isEqual:[NSNull null]] || !order.payDate) {
    //            self.orderNeedMoneyTitle.hidden = YES;
    //            self.orderNeedMoney.hidden = YES;
    //        }
    //        self.sepLineView.hidden = YES;
    //        [self.sepLineView mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(RETINA_1PX);
    //            make.top.equalTo(weakSelf.contentView).offset(0);
    //            make.leading.equalTo(weakSelf.contentView).offset(16);
    //            make.trailing.equalTo(weakSelf.contentView).offset(-16);
    //        }];
    //        [self.orderStatus mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.leading.equalTo(weakSelf.contentView).offset(16);
    //            make.top.equalTo(weakSelf.sepLineView).offset(32);
    //        }];
    //    }else{
    //        self.orderNeedMoneyTitle.hidden = NO;
    //        self.orderNeedMoney.hidden = NO;
    //        self.sepLineView.hidden = NO;
    //    }
    //    //modify by Thomas O2O订单详情里面不展示实际支付金额－－－end
    
    
    
    
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
        if([order.orderHeader.orderStatus isEqualToString: SZ_RETURN_REQUESTED]) self.orderStatus.text =@"退款中"; //
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
        if([order.orderHeader.orderStatus isEqualToString:SZ_RETURN_COMPLETED]) self.orderStatus.text =@"已关闭";//
        
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
        if([order.orderHeader.orderStatus isEqualToString: SZ_RETURN_REQUESTED]) self.orderStatus.text =@"退款中"; //
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
        if([order.orderHeader.orderStatus isEqualToString:SZ_RETURN_COMPLETED]) self.orderStatus.text =@"已关闭";//
    }
    
    if ([order.orderHeader.orderStatus isEqualToString:SZ_ORDER_COMPLETED]) {
        self.orderStatus.textColor = [UIColor colorFromHexRGB:@"8fc31fs"];
    }else{
        self.orderStatus.textColor =[UIColor colorFromHexRGB:@"ff6600"];
    }
    
    
    
    
    //Modify by Thomas[增加取消预约:订单状态ORDER_CREATED订单类型SALES_ORDER_O2O_SERVICE]---start
    //    /**
    //     * 预约中
    //     */
    //    if([order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_O2O_SERVICE] ){
    //        if ([order.orderHeader.orderStatus isEqualToString: ORDER_CREATED] || [order.orderHeader.orderStatus isEqualToString: ORDER_APPROVED]) self.orderStatus.text =@"预约中";//
    //        if ([order.orderHeader.orderStatus isEqualToString: ORDER_PROCESSING]) self.orderStatus.text =@"商家已确认";//
    //    }
    //    if ([order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_O2O_SERVICE] ){
    //        if ([order.orderHeader.orderStatus isEqualToString: ORDER_APPROVED]) {
    //            self.oneButton.hidden = YES;
    //            self.twoButton.hidden = YES;
    //            self.threeButton.hidden = NO;
    //            [self.threeButton setTitle:@"取消预约" forState:UIControlStateNormal];
    //            [self.threeButton setTitleColor:[UIColor colorFromHexRGB:@"ff6600"] forState:UIControlStateNormal];
    //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"ff6600"]CGColor];
    //        }else if([order.orderHeader.orderStatus isEqualToString: ORDER_PROCESSING]){
    //            self.oneButton.hidden = YES;
    //            self.twoButton.hidden = YES;
    //            self.threeButton.hidden = NO;
    //            [self.threeButton setTitle:@"买单" forState:UIControlStateNormal];
    //            [self.threeButton setTitleColor:[UIColor colorFromHexRGB:@"ff6600"] forState:UIControlStateNormal];
    //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"ff6600"]CGColor];
    //        }else{
    //            self.oneButton.hidden = YES;
    //            self.twoButton.hidden = YES;
    //            self.threeButton.hidden = YES;
    //        }
    //        
    //    }else
    //        //Modify by Thomas[增加取消预约:订单状态ORDER_CREATED订单类型SALES_ORDER_O2O_SERVICE]---end
    
    if ([order.orderHeader.orderStatus isEqualToString: SZ_ORDER_CREATED]) {// 订单初始状态,待付款
        
        self.oneButton.hidden = YES;
        self.twoButton.hidden = NO;
        self.threeButton.hidden = NO;
        
        [self.threeButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.twoButton setTitle:@"去支付" forState:UIControlStateNormal];
        
        //        [self.twoButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
        //        self.twoButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
        
        [self.twoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.twoButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
        [self.threeButton setTitleColor:[UIColor colorFromHexRGB:@"848281"] forState:UIControlStateNormal];
        self.threeButton.backgroundColor = [UIColor clearColor];
        
        
        //        self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"ff6600"]CGColor];
        
    } else if ([order.orderHeader.orderStatus isEqualToString:SZ_ORDER_PROCESSING]) {// 待发货
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = YES;
        //        if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY] && [order.orderHeader.isCanRefund isEqualToString:@"Y"]) {
        //            self.threeButton.hidden = NO;
        //            [self.threeButton setTitle:@"申请退款" forState:UIControlStateNormal];
        //            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
        //            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
        //        }else if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE] && [order.orderHeader.isCanRefund isEqualToString:@"Y"]) {
        //            self.threeButton.hidden = NO;
        //            [self.threeButton setTitle:@"退款/退货" forState:UIControlStateNormal];
        //            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
        //            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
        //            
        //        }
        
        
    } else if ([order.orderHeader.orderStatus isEqualToString:SZ_ORDER_SENT]) {// 待收货
        
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = YES;
        
        if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY]&&[order.orderHeader.isCanRefund isEqualToString:@"Y"]) {
            //            self.threeButton.hidden = NO;
            //            [self.threeButton setTitle:@"申请退款" forState:UIControlStateNormal];
            //            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
            //            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
        }else if([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE]){
            
            //            if ([order.orderHeader.isCanRefund isEqualToString:@"Y"]) {
            //                self.oneButton.hidden = NO;
            //                [self.twoButton setTitle:@"查看物流" forState:UIControlStateNormal];
            //                
            //                self.twoButton.hidden = NO;
            //                self.threeButton.hidden = NO;
            //                
            //                [self.threeButton setTitle:@"退款/退货" forState:UIControlStateNormal];
            //                [self.oneButton setTitle:@"确认收货" forState:UIControlStateNormal];
            //                
            //                [self.oneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //                self.oneButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
            //            }else{
            self.oneButton.hidden = YES;
            [self.twoButton setTitle:@"确认收货" forState:UIControlStateNormal];
            
            self.twoButton.hidden = NO;
            self.threeButton.hidden = NO;
            
            [self.threeButton setTitle:@"查看物流" forState:UIControlStateNormal];
            
            
            [self.twoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.twoButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
            //  }
            
            
            
            //            [self.oneButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
            //            self.oneButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
            //            [self.twoButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
            //            self.twoButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
            //            [self.threeButton setTitleColor:[UIColor colorFromHexRGB:@"ff6600"] forState:UIControlStateNormal];
            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"ff6600"]CGColor];
            
        }
        
        
    } else if ([order.orderHeader.orderStatus isEqualToString:SZ_ORDER_COMPLETED]/*&& [order.orderHeader.isCanRate isEqualToString:@"Y"]*/) {// 订单完成
        
        
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = YES;
        
        if ([order.orderHeader.invoiceStatus isEqualToString:@""]) {
            self.threeButton.hidden = NO;
            [self.threeButton setTitle:@"发票申请" forState:UIControlStateNormal];
            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
        } else if ([order.orderHeader.invoiceStatus isEqualToString:@"NOT_ACCEPT"]) {
            self.threeButton.hidden = NO;
            [self.threeButton setTitle:@"发票申请-待受理" forState:UIControlStateNormal];
            [self.threeButton setTitleColor:ColorWithHex(0x8fc31f, 1.0) forState:UIControlStateNormal];
            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0xffffff"];
            [self.threeButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.orderStatus);
                make.trailing.equalTo(self.contentView).offset(-16);
                make.height.equalTo(@30);
                make.width.equalTo(@100);
            }];
        } else if ([order.orderHeader.invoiceStatus isEqualToString:@"ACCEPT"]) {
            self.threeButton.hidden = NO;
            [self.threeButton setTitle:@"发票申请-已受理" forState:UIControlStateNormal];
            [self.threeButton setTitleColor:ColorWithHex(0x8fc31f, 1.0) forState:UIControlStateNormal];
            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0xffffff"];
            [self.threeButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.orderStatus);
                make.trailing.equalTo(self.contentView).offset(-16);
                make.height.equalTo(@30);
                make.width.equalTo(@100);
            }];
        }
        
        //评价
        if ([order.orderHeader.isCanRate isEqualToString:@"Y"]) {
            if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY]) {
                self.twoButton.hidden = NO;
                [self.twoButton setTitle:@"去评价" forState:UIControlStateNormal];
                [self.twoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.twoButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
            }else{
                self.twoButton.hidden = NO;
                [self.twoButton setTitle:@"去评价" forState:UIControlStateNormal];
                [self.twoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.twoButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
            }
        }
        
        //查看物流
        if ([order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_B2C]) {
            self.oneButton.hidden = NO;
            [self.oneButton setTitle:@"查看物流" forState:UIControlStateNormal];
            [self.oneButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
            self.oneButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
        }else{
            self.oneButton.hidden = YES;
            [self.oneButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
            self.oneButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
        }
        

        
    } else if ([order.orderHeader.orderStatus isEqualToString:SZ_ORDER_APPROVED]) {// 待接单
        
        
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = YES;
        
        //        if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY] && [order.orderHeader.isCanRefund isEqualToString:@"Y"]) {
        //            self.threeButton.hidden = NO;
        //            [self.threeButton setTitle:@"申请退款" forState:UIControlStateNormal];
        //            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
        //            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
        //        }else  if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE] && [order.orderHeader.isCanRefund isEqualToString:@"Y"]){
        //            self.threeButton.hidden = NO;
        //            [self.threeButton setTitle:@"退款/退货" forState:UIControlStateNormal];
        //            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
        //            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
        //            
        //        }
        
        
        
    } else {
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = YES;
    }
    
}


- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.orderNeedMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.top.equalTo(weakSelf.contentView).offset(11);
    }];
    
    [self.orderNeedMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.orderNeedMoneyTitle.mas_trailing).offset(5);
        make.centerY.equalTo(weakSelf.orderNeedMoneyTitle);
    }];
    
    [self.sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(RETINA_1PX);
        make.top.equalTo(weakSelf.contentView).offset(34);
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
    }];
    
    [self.orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.top.equalTo(weakSelf.sepLineView).offset(28);
    }];
    
    [self.threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.orderStatus);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        make.height.equalTo(@30);
        make.width.equalTo(@70);
    }];
    
    [self.twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.orderStatus);
        make.trailing.equalTo(weakSelf.threeButton.mas_leading).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@70);
    }];
    
    [self.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.orderStatus);
        make.trailing.equalTo(weakSelf.twoButton.mas_leading).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@70);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
        make.bottom.equalTo(weakSelf.contentView);
    }];
}






@end
