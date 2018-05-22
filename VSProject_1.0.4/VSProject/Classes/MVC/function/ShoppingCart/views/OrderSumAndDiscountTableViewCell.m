//
//  OrderSumAndDiscountTableViewCell.m
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import "OrderSumAndDiscountTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation OrderSumAndDiscountTableViewCell

- (UILabel *)discountLabel{
    
    if (_discountLabel == nil) {
        _discountLabel = [UILabel new];
        _discountLabel.textColor = [UIColor colorFromHexRGB:@"999999"];
        _discountLabel.font = [UIFont systemFontOfSize:12];
        _discountLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_discountLabel addGestureRecognizer:tapGesture];
    }
    
    return _discountLabel;
}


- (UILabel *)remarkTitleLabel{
    
    if (_remarkTitleLabel == nil) {
        _remarkTitleLabel = [UILabel new];
        _remarkTitleLabel.textColor = [UIColor colorFromHexRGB:@"999999"];
        _remarkTitleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _remarkTitleLabel;
    
}

- (UILabel *)couponLabel{
    
    if (_couponLabel == nil) {
        _couponLabel = [UILabel new];
        _couponLabel.textColor = [UIColor colorFromHexRGB:@"999999"];
        _couponLabel.font = [UIFont systemFontOfSize:12];
        _couponLabel.textAlignment = NSTextAlignmentRight;
        _couponLabel.userInteractionEnabled = YES;
        _couponLabel.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_couponLabel addGestureRecognizer:tapGesture];
    }
    
    return _couponLabel;
}
- (void)tapAction{
    
    _couponBlock();
}

- (UIImageView *)descImageView{
    
    if (_descImageView == nil) {
        _descImageView = [UIImageView new];
        _descImageView.image = [UIImage imageNamed:@"修改"];
    }
    
    return _descImageView;
}

- (UITextView *)messageTextView{
    
    if (_messageTextView == nil) {
        _messageTextView = [UITextView new];
        _messageTextView.layer.cornerRadius = 3;
        _messageTextView.layer.masksToBounds = YES;
        _messageTextView.layer.borderColor = [[UIColor colorFromHexRGB:@"dbdbdb"] CGColor];
        _messageTextView.layer.borderWidth = 1;
        _messageTextView.delegate = self;
        _messageTextView.textColor = [UIColor colorFromHexRGB:@"999999"];
        
        
    }
    
    return _messageTextView;
}

- (void)setOrderTypeId:(NSString *)orderTypeId{
    _orderTypeId = orderTypeId;
    
    
    __weak typeof(self) weakSelf = self;
    
    if ([self.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE]
        || [self.orderTypeId isEqualToString:SZ_SALES_ORDER_SUBSCRIBE]
        || [self.orderTypeId isEqualToString:SZ_SPACE_ORDER_SUBSCRIBE]) {
        
        
        self.remarkTitleLabel.text = @"备注：";
        
        [self.discountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
//        [self.couponLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@0);
//        }];
//        
        [self.descImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
        [self.remarkTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakSelf.contentView).offset(16);
            make.trailing.equalTo(weakSelf.contentView).offset(-16);
            make.top.equalTo(weakSelf.couponLabel.mas_bottom).offset(5);
        }];
        
        [self.messageTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.remarkTitleLabel.mas_bottom).offset(5);
            make.leading.equalTo(weakSelf.contentView).offset(16);
            make.trailing.equalTo(weakSelf.contentView).offset(-16);
            make.height.mas_equalTo(@53);
        }];
        
        
    }else{
        
        self.remarkTitleLabel.text = @"需求表单:";
        
        [self.discountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
//        [self.couponLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@0);
//        }];
        
        [self.descImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
        [self.remarkTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakSelf.contentView).offset(16);
            make.trailing.equalTo(weakSelf.contentView).offset(-16);
            make.top.equalTo(weakSelf.couponLabel.mas_bottom).offset(5);
        }];
        
        [self.messageTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.remarkTitleLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(@103);
            make.leading.equalTo(weakSelf.contentView).offset(16);
            make.trailing.equalTo(weakSelf.contentView).offset(-16);
        }];
        
        if (self.messageTextView.text.length == 0) {
            //            self.messageTextView.text = @"1、企业规模描述\n2、企业类型描述\n3、供融资规模描述\n4、其他信息描述";
            self.messageTextView.text = self.orderDemand;
        }
        
    }
}

- (UILabel *)totalLabel{
    
    if (_totalLabel == nil) {
        _totalLabel = [UILabel new];
        _totalLabel.textColor = [UIColor colorFromHexRGB:@"343434"];
        _totalLabel.font = [UIFont systemFontOfSize:12];
        _totalLabel.text = @"合计:";
    }
    
    return _totalLabel;
}

- (UILabel *)totalMoney{
    
    if (_totalMoney == nil) {
        _totalMoney = [UILabel new];
        _totalMoney.font = [UIFont systemFontOfSize:12];
        _totalMoney.textColor = [UIColor colorFromHexRGB:@"ff3636"];
    }
    
    return _totalMoney;
}

- (UILabel *)postMoney{
    
    if (_postMoney == nil) {
        _postMoney = [UILabel new];
        _postMoney.font = [UIFont systemFontOfSize:10];
        _postMoney.textColor = [UIColor colorFromHexRGB:@"ff3636"];
    }
    
    return _postMoney;
    
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
        
        [self.contentView addSubview:self.discountLabel];
        [self.contentView addSubview:self.couponLabel];
        [self.contentView addSubview:self.descImageView];
        [self.contentView addSubview:self.remarkTitleLabel];
        [self.contentView addSubview:self.messageTextView];
        
        [self.contentView addSubview:self.totalLabel];
        [self.contentView addSubview:self.totalMoney];
        [self.contentView addSubview:self.postMoney];
        
        [self.contentView addSubview:self.bottomLineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
     
        
        [self updateConstraintsForSubviews];
    }
    
    return self;
    
}


- (void)setShoppingCartInfoDTO:(ShoppingCartInfoDTO *)shoppingCartInfoDTO{
    
    _shoppingCartInfoDTO = shoppingCartInfoDTO;
    
    if (_shoppingCartInfoDTO.promoAmount.floatValue < 0) {
        
        self.discountLabel.text = [NSString stringWithFormat:@"您已优惠:¥ %.2f",-shoppingCartInfoDTO.promoAmount.floatValue];
        
        
    }else{
        
        //        self.discountLabel.text = [NSString stringWithFormat:@"请输入兑换码"];
        self.discountLabel.text = [NSString stringWithFormat:@"可用优惠券"];
        
    }
    
    self.discountLabel.hidden = NO;
    self.descImageView.hidden = NO;
    
    self.totalMoney.text = [NSString stringWithFormat: @"¥ %.2f",shoppingCartInfoDTO.totalPayAmount.doubleValue];
    self.postMoney.text =  [NSString stringWithFormat: @"（含运费¥ %@）",shoppingCartInfoDTO.totalShipping];
    self.postMoney.hidden = YES;
}


- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
    [self.couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.contentView).offset(-30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(40);
        make.top.equalTo(weakSelf.contentView).offset(5);
    }];
    
    [self.descImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.discountLabel);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
    }];
    
    [self.messageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(46);
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        make.height.mas_equalTo(@53);
    }];
    
    [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.messageTextView.mas_bottom).offset(13);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.totalMoney);
        make.trailing.equalTo(weakSelf.totalMoney.mas_leading).offset(-8);
    }];
    
    [self.postMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        make.top.equalTo(weakSelf.totalMoney.mas_bottom).offset(6);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
}


#pragma mark -
#pragma mark UITextView delegtate method

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([self.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY]) {
        if ([textView.text isEqualToString:self.orderDemand]) {
            textView.text = @"";
        }
    }
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([self.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY]) {
        if ([textView.text isEqualToString:@""]) {
            //            textView.text = @"1、企业规模描述\n2、企业类型描述\n3、供融资规模描述\n4、其他信息描述";
            self.messageTextView.text = self.orderDemand;
        }
        if (self.remarkBlock) {
            NSString *content = textView.text;
            if ([content isEqualToString:self.orderDemand]) {
                content = @"";
            }
            self.remarkBlock(content);
        }
    }else{
        if (self.remarkBlock) {
            NSString *content = textView.text;
            
            self.remarkBlock(content);
        }
    }
}

#pragma mark -
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    textField.text = @"  ";
}

- (NSString *)orderDemand{
    if (_orderDemand == nil) {
        _orderDemand = @"";
    }
    return _orderDemand;
}

@end
