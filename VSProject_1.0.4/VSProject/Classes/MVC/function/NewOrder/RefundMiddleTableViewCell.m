//
//  RefundMiddleTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/2.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RefundMiddleTableViewCell.h"
#import "UIColor+TPCategory.h"
#import "OrderHeader.h"

@implementation RefundMiddleTableViewCell

- (UILabel *)orderStatusLabel{
    
    if (_orderStatusLabel == nil) {
        _orderStatusLabel = [UILabel new];
        _orderStatusLabel.font = [UIFont systemFontOfSize:10];
        _orderStatusLabel.textColor =[UIColor colorFromHexRGB:@"343434"];
    }
    
    return _orderStatusLabel;
}

- (UILabel *) bottomLineView{
    
    if (_bottomLineView == nil) {
        _bottomLineView = [UILabel new];
        _bottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"a8a8a8"];
    }
    
    return _bottomLineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.orderStatusLabel];
        [self.contentView addSubview:self.bottomLineView];
        self.contentView.backgroundColor = _Colorhex(0xf1f1f1);
        [self updateConstraintsForSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)updateConstraintsForSubViews{
    __weak typeof(self) weakSelf = self;
    
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.contentView).offset(10);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(@0.5);
    }];
}

- (void)setOrder:(Order *)order{
    _order = order;
    
    NSString *str = nil;
    
    if ([self.order.orderHeader.orderStatus isEqualToString: SZ_RETURN_REQUESTED]) {
        str = @"您的退款申请正在进行中，请耐心等待～";
    }else if ([self.order.orderHeader.orderStatus isEqualToString: SZ_RETURN_ACCEPTED]) {
        str = @"您的退款申请已同意，将在10个工作日内完成退款。";
    }else if ([self.order.orderHeader.orderStatus isEqualToString: SZ_RETURN_MAN_REFUND]) {
        str = @"您的退款申请被拒绝。";
    }else if ([self.order.orderHeader.orderStatus isEqualToString: SZ_RETURN_COMPLETED]) {
        str = [NSString stringWithFormat:@"您申请的退款已退回您的%@帐户中。",[self.dto.orderHeader.paymentType isEqualToString:@"EXT_ALIPAY"]?@"支付宝":@"微信"];
    }
    
    self.orderStatusLabel.text = str;
    
}

@end






























