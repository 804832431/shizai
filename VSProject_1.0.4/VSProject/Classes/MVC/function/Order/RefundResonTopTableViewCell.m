//
//  RefundResonTopTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/8/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RefundResonTopTableViewCell.h"
#import "Order.h"
#import "OrderHeader.h"
@implementation RefundResonTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = _Colorhex(0xf1f1f1);
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setOrder:(Order *)order{
    _order = order;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",self.order.orderHeader.grandTotal];
    
}

@end
