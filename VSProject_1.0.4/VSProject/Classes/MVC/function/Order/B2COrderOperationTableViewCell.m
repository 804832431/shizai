//
//  B2COrderOperationTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "B2COrderOperationTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation B2COrderOperationTableViewCell

//- (UILabel *)sepLineView{
//    
//    if (_sepLineView == nil) {
//        _sepLineView = [UILabel new];
//        _sepLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
//        
//    }
//    
//    return _sepLineView;
//    
//}

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



- (UIButton *)oneButton{
    
    if (_oneButton == nil) {
        _oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_oneButton setTitleColor:[UIColor colorFromHexRGB:@"35b38d"] forState:UIControlStateNormal];
        _oneButton.layer.borderColor = [[UIColor colorFromHexRGB:@"35b38d"]CGColor];
        _oneButton.layer.masksToBounds = YES;
        _oneButton.layer.cornerRadius = 5;
        
        _oneButton.layer.borderWidth = 0.5;
        _oneButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_oneButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _oneButton;
}


- (UIButton *)twoButton{
    
    if (_twoButton == nil) {
        _twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_twoButton setTitleColor:[UIColor colorFromHexRGB:@"35b38d"] forState:UIControlStateNormal];
        _twoButton.layer.borderColor = [[UIColor colorFromHexRGB:@"35b38d"]CGColor];
        _twoButton.layer.masksToBounds = YES;
        _twoButton.layer.cornerRadius = 5;
        
        _twoButton.layer.borderWidth = 0.5;
        _twoButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_twoButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _twoButton;
}

- (UIButton *)threeButton{
    
    if (_threeButton == nil) {
        _threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_threeButton setTitleColor:[UIColor colorFromHexRGB:@"35b38d"] forState:UIControlStateNormal];
        _threeButton.layer.borderColor = [[UIColor colorFromHexRGB:@"35b38d"]CGColor];
        _threeButton.layer.masksToBounds = YES;
        _threeButton.layer.cornerRadius = 5;
        _threeButton.layer.borderWidth = 0.5;
        _threeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_threeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _threeButton;
}

- (void)buttonAction:(UIButton *)button{
    
    NSString *title = [button currentTitle];
    
    if ([title  isEqualToString:@"取消订单"]) {
        
        if (self.cancelOrder) {
            self.cancelOrder(self.order);
        }
        
    }else if ([title  isEqualToString:@"付款"]) {
        
        if (self.payOrder) {
            self.payOrder(self.order);
        }
    }else if ([title  isEqualToString:@"退款/退货"]) {
        
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
    }
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
//        [self.contentView addSubview:self.orderStatus];
        [self.contentView addSubview:self.oneButton];
        [self.contentView addSubview:self.twoButton];
        [self.contentView addSubview:self.threeButton];
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
    
    
    
    if ([order.orderHeader.orderStatus isEqualToString: ORDER_CREATED]) {// 订单初始状态,待付款
        
        self.oneButton.hidden = YES;
        self.twoButton.hidden = NO;
        self.threeButton.hidden = NO;
        
        [self.twoButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.threeButton setTitle:@"付款" forState:UIControlStateNormal];
        
        
    } else if ([order.orderHeader.orderStatus isEqualToString:ORDER_PROCESSING]) {// 待发货
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = NO;
        [self.threeButton setTitle:@"退款/退货" forState:UIControlStateNormal];
        
        
    } else if ([order.orderHeader.orderStatus isEqualToString:ORDER_SENT]) {// 待收货
        self.oneButton.hidden = YES;
        self.twoButton.hidden = NO;
        self.threeButton.hidden = NO;
        //        [self.oneButton setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.twoButton setTitle:@"退款/退货" forState:UIControlStateNormal];
        [self.threeButton setTitle:@"确认收货" forState:UIControlStateNormal];
        
        
    } else if ([order.orderHeader.orderStatus isEqualToString:ORDER_COMPLETED]) {// 订单完成
        
        
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = YES;
        
        //        [self.threeButton setTitle:@"查看物流" forState:UIControlStateNormal];
        
        
    } else if ([order.orderHeader.orderStatus isEqualToString:ORDER_APPROVED]) {// 待接单
        
        
        self.oneButton.hidden = YES;
        self.twoButton.hidden = YES;
        self.threeButton.hidden = NO;
        
        [self.threeButton setTitle:@"退款/退货" forState:UIControlStateNormal];
        
        
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
        make.top.equalTo(weakSelf.contentView).offset(28);
    }];
    
    [self.orderNeedMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.orderNeedMoneyTitle.mas_trailing).offset(5);
        make.centerY.equalTo(weakSelf.orderNeedMoneyTitle);
    }];
    
    
    [self.threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.orderNeedMoney);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        make.height.equalTo(@30);
        make.width.equalTo(@70);
    }];
    
    [self.twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.orderNeedMoney);
        make.trailing.equalTo(weakSelf.threeButton.mas_leading).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@70);
    }];
    
    [self.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.orderNeedMoney);
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
