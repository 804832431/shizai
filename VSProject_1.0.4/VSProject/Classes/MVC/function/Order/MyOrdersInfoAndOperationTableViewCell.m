//
//  MyOrdersInfoAndOperationTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/22.
//  Copyright © 2015年 user. All rights reserved.
//

#import "MyOrdersInfoAndOperationTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation MyOrdersInfoAndOperationTableViewCell

- (UILabel *)totalMoney{
    
    if (_totalMoney == nil) {
        _totalMoney = [UILabel new];
        _totalMoney.textColor = [UIColor colorFromHexRGB:@"333333"];
        _totalMoney.font = [UIFont systemFontOfSize:12];
    }
    
    return _totalMoney;
}




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

- ( UILabel *)bottomLineView{
    
    if (_bottomLineView == nil) {
        _bottomLineView = [UILabel new];
        _bottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
        
    }
    
    return _bottomLineView;
}

- (UIView *)sepBottomView{
    
    if (_sepBottomView == nil) {
        
        _sepBottomView = [UIView new];
        _sepBottomView.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        
    }
    
    return _sepBottomView;
}


#pragma mark -

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.totalMoney];
        [self.contentView addSubview:self.oneButton];
        [self.contentView addSubview:self.twoButton];
        [self.contentView addSubview:self.threeButton];
        [self.contentView addSubview:self.bottomLineView];
        [self.contentView addSubview:self.sepBottomView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubviews];
    }
    
    
    return self;
}

- (void)setOrder:(Order *)order{
    
    _order = order;
    
    self.totalMoney.text = [NSString stringWithFormat:@"总价:¥ %@",order.orderHeader.grandTotal];
    //    //Modify by Thomas[增加取消预约:订单状态ORDER_CREATED订单类型SALES_ORDER_O2O_SERVICE]---start
    //    if ([order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_O2O_SERVICE] ){
    //        //modify by Thomas [换算时间供页面展示]－－－start
    //        self.totalMoney.text = [NSString stringWithFormat:@"预约时间: %@",[self dataTimeWith:order.orderHeader.reservationDate]?:order.orderHeader.reservationDate];
    //        //modify by Thomas [换算时间供页面展示]－－－end
    //        if ([order.orderHeader.orderStatus isEqualToString: ORDER_CREATED] || [order.orderHeader.orderStatus isEqualToString: ORDER_APPROVED]) {
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
    //        }
    //        else{
    //            self.oneButton.hidden = YES;
    //            self.twoButton.hidden = YES;
    //            self.threeButton.hidden = YES;
    //        }
    //        
    //    }else
    //Modify by Thomas[增加取消预约:订单状态ORDER_CREATED订单类型SALES_ORDER_O2O_SERVICE]---end
    
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
        
        if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY]&&  [order.orderHeader.isCanRefund isEqualToString:@"Y"]) {
            self.threeButton.hidden = NO;
            [self.threeButton setTitle:@"申请退款" forState:UIControlStateNormal];
            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
        }else if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE] &&  [order.orderHeader.isCanRefund isEqualToString:@"Y"]){
            self.threeButton.hidden = NO;
            [self.threeButton setTitle:@"退款/退货" forState:UIControlStateNormal];
            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
            
        }
        
        
    } else if ([order.orderHeader.orderStatus isEqualToString:SZ_ORDER_SENT]) {// 待收货
        
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = YES;
        
        if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY] &&  [order.orderHeader.isCanRefund isEqualToString:@"Y"]) {
            self.threeButton.hidden = NO;
            [self.threeButton setTitle:@"申请退款" forState:UIControlStateNormal];
            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
        }else if([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE]){
            
            
            if ( [order.orderHeader.isCanRefund isEqualToString:@"Y"]) {
                self.oneButton.hidden = NO;
                [self.twoButton setTitle:@"查看物流" forState:UIControlStateNormal];
                
                self.twoButton.hidden = NO;
                self.threeButton.hidden = NO;
                
                [self.threeButton setTitle:@"退款/退货" forState:UIControlStateNormal];
                [self.oneButton setTitle:@"确认收货" forState:UIControlStateNormal];
                
                [self.oneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.oneButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
            }else{
                self.oneButton.hidden = YES;
                [self.twoButton setTitle:@"确认收货" forState:UIControlStateNormal];
                
                self.twoButton.hidden = NO;
                self.threeButton.hidden = NO;
                
                [self.threeButton setTitle:@"查看物流" forState:UIControlStateNormal];
                
                [self.twoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.twoButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
            }
            
            
            
            //            [self.oneButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
            //            self.oneButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
            //            [self.twoButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
            //            self.twoButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
            //            [self.threeButton setTitleColor:[UIColor colorFromHexRGB:@"ff6600"] forState:UIControlStateNormal];
            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"ff6600"]CGColor];
            
        }
        
        
    } else if ([order.orderHeader.orderStatus isEqualToString:SZ_ORDER_COMPLETED]/* && [order.orderHeader.isCanRate isEqualToString:@"Y"]*/) {// 订单完成
        
        
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = YES;
        
        //        if ([order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_B2C]) {
        //            self.threeButton.hidden = NO;
        //            [self.threeButton setTitle:@"查看物流" forState:UIControlStateNormal];
        //        }else{
        //            self.threeButton.hidden = YES;
        //        }
        //        [self.threeButton setTitleColor:[UIColor colorFromHexRGB:@"7c7c7c"] forState:UIControlStateNormal];
        //        self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
        
//        if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY]) {
//            self.threeButton.hidden = NO;
//            [self.threeButton setTitle:@"去评价" forState:UIControlStateNormal];
//            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
//        }else{
//            self.threeButton.hidden = NO;
//            [self.threeButton setTitle:@"去评价" forState:UIControlStateNormal];
//            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
//        }
        
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
                make.centerY.equalTo(self.totalMoney);
                make.trailing.equalTo(self.contentView).offset(-10);
                make.height.equalTo(@20);
                make.width.equalTo(@100);
            }];
        } else if ([order.orderHeader.invoiceStatus isEqualToString:@"ACCEPT"]) {
            self.threeButton.hidden = NO;
            [self.threeButton setTitle:@"发票申请-已受理" forState:UIControlStateNormal];
            [self.threeButton setTitleColor:ColorWithHex(0x8fc31f, 1.0) forState:UIControlStateNormal];
            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0xffffff"];
            [self.threeButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.totalMoney);
                make.trailing.equalTo(self.contentView).offset(-10);
                make.height.equalTo(@20);
                make.width.equalTo(@100);
            }];
        }
        
    } else if ([order.orderHeader.orderStatus isEqualToString:SZ_ORDER_APPROVED]) {// 待接单
        
        
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = YES;
        
        if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY] &&  [order.orderHeader.isCanRefund isEqualToString:@"Y"]) {
            self.threeButton.hidden = NO;
            [self.threeButton setTitle:@"申请退款" forState:UIControlStateNormal];
            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
        }else  if ([order.orderHeader.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE] &&  [order.orderHeader.isCanRefund isEqualToString:@"Y"]) {
            self.threeButton.hidden = NO;
            [self.threeButton setTitle:@"退款/退货" forState:UIControlStateNormal];
            [self.threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //            self.threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"7c7c7c"]CGColor];
            self.threeButton.backgroundColor = [UIColor colorFromHexRGB:@"0x35b38d"];
            
        }
        
        
        
    } else {
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = YES;
    }
    
}

- (void)buttonAction:(UIButton *)button{
    
    NSString *title = [button currentTitle];
    //Modify by Thomas[增加取消预约/买单:订单状态ORDER_CREATED／ORDER_PROCESSING订单类型SALES_ORDER_O2O_SERVICE]---start
    //    if ([title  isEqualToString:@"取消预约"]) {
    //        
    //        if (self.cancelAppointment) {
    //            self.cancelAppointment(self.order);
    //        }
    //        
    //    }if ([title  isEqualToString:@"买单"]) {
    //        
    //        if (self.readyPayOrder) {
    //            self.readyPayOrder(self.order);
    //        }
    //        
    //    }else
    //Modify by Thomas[增加取消预约:订单状态ORDER_CREATED订单类型SALES_ORDER_O2O_SERVICE]---end
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
    }else if ([title  isEqualToString:@"发票申请"]) {
        if (self.applyInvoice) {
            self.applyInvoice(self.order);
        }
    }
}

- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.centerY.equalTo(weakSelf.contentView).offset(-6);
    }];
    
    [self.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.totalMoney);
        make.trailing.equalTo(weakSelf.twoButton.mas_leading).offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
        
    }];
    
    
    [self.twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.totalMoney);
        make.trailing.equalTo(weakSelf.threeButton.mas_leading).offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
        
    }];
    
    [self.threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.totalMoney);
        make.trailing.equalTo(weakSelf.contentView).offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
        
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
        
    }];
    
    [self.sepBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.bottomLineView.mas_bottom);
        make.height.mas_equalTo(13);
        make.bottom.equalTo(weakSelf.contentView);
    }];
}
//add by Thomas [换算时间供页面展示]－－－start
//转换时间显示
- (NSString *)dataTimeWith:(NSString *)str{
    if (![str isEqual:[NSNull null]] && str.length > 0) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        NSDateFormatter *dateFomatter2 = [NSDateFormatter new];
        [dateFomatter2 setDateFormat:@"yyyyMMddHHmmss"];
        return  [dateFormatter stringFromDate:[dateFomatter2 dateFromString:str]];
    }
    return @"";
    
}
//add by Thomas [换算时间供页面展示]－－－end
@end
