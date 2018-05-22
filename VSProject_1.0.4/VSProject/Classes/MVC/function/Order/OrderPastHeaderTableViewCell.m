//
//  OrderPastHeaderTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import "OrderPastHeaderTableViewCell.h"
#import "UIColor+TPCategory.h"
#import "OrderPostAddress.h"

@implementation OrderPastHeaderTableViewCell

- (UILabel *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [UILabel new];
        _bottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    
    return _bottomLineView;
}

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


- (UILabel *)orderPastHeaderPostIdContent{
    
    if (_orderPastHeaderPostIdContent == nil) {
        
        _orderPastHeaderPostIdContent = [UILabel new];
        
        _orderPastHeaderPostIdContent.font = [UIFont systemFontOfSize:15.0f];
        
        _orderPastHeaderPostIdContent.textColor = [UIColor colorFromHexRGB:@"969696"];
        
        
    }
    
    return _orderPastHeaderPostIdContent;
}

- (UILabel *)orderPastHeaderPostIdContentValue{
    
    if (_orderPastHeaderPostIdContentValue == nil) {
        
        _orderPastHeaderPostIdContentValue = [UILabel new];
        
        _orderPastHeaderPostIdContentValue.textAlignment = NSTextAlignmentLeft;
        
        _orderPastHeaderPostIdContentValue.font = [UIFont systemFontOfSize:15.0f];
        
        _orderPastHeaderPostIdContentValue.textColor = [UIColor colorFromHexRGB:@"969696"];
        
        _orderPastHeaderPostIdContentValue.numberOfLines = 0;
    }
    
    return _orderPastHeaderPostIdContentValue;
}

- (UILabel *)orderPastHeaderCompanyContent{
    
    if (_orderPastHeaderCompanyContent == nil) {
        
        _orderPastHeaderCompanyContent = [UILabel new];
        
        _orderPastHeaderCompanyContent.font = [UIFont systemFontOfSize:15.0f];
        
        _orderPastHeaderCompanyContent.textColor = [UIColor colorFromHexRGB:@"969696"];
        
        
    }
    
    return _orderPastHeaderCompanyContent;
}

- (UILabel *)orderPastHeaderContent{
    
    if (_orderPastHeaderContent == nil) {
        
        _orderPastHeaderContent = [UILabel new];
        
        _orderPastHeaderContent.font = [UIFont systemFontOfSize:15.0f];
        
        _orderPastHeaderContent.textColor = [UIColor colorFromHexRGB:@"969696"];
        
        _orderPastHeaderContent.text = @"配送信息";
    }
    
    return _orderPastHeaderContent;
}


#pragma mark -

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.topLineView];
        [self.contentView addSubview:self.orderPastHeaderCompanyContent];
        [self.contentView addSubview:self.orderPastHeaderPostIdContent];
        [self.contentView addSubview:self.orderPastHeaderPostIdContentValue];
        [self.contentView addSubview:self.middleLineView];
        [self.contentView addSubview:self.orderPastHeaderContent];
        [self.contentView addSubview:self.bottomLineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubviews];
    }
    
    
    self.orderPastHeaderPostIdContentValue.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width/2- 16-65;
    
    return self;
}


- (void)setOrder:(Order *)order{
    
    _order = order;
    
    if ([order.expressCompany isEqual:[NSNull null]]) {
        order.expressCompany = @"";
    }
    
    if ([order.trackingNum isEqual:[NSNull null]]) {
        order.trackingNum = @"";
    }
    
    if (order.expressCompany.length == 0 || order.trackingNum.length == 0) {
        
        __weak typeof(&*self) weakSelf = self;
        
        [self.orderPastHeaderCompanyContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakSelf.contentView).offset(16);
            make.top.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(0);
            
            
        }];
        
        
        [self.orderPastHeaderPostIdContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakSelf.orderPastHeaderCompanyContent.mas_trailing).offset(30);
            make.top.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(0);
            
        }];
        
        [self.orderPastHeaderContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.equalTo(weakSelf.orderPastHeaderCompanyContent);
            make.top.equalTo(weakSelf.contentView);
            make.trailing.equalTo(weakSelf.contentView.mas_trailing).offset(-16);
            make.bottom.equalTo(weakSelf.contentView);
            
            
        }];
        
        self.middleLineView.hidden = YES;
        self.orderPastHeaderCompanyContent.hidden = YES;
        self.orderPastHeaderPostIdContent.hidden = YES;
    }
    
    self.orderPastHeaderCompanyContent.text = [NSString stringWithFormat:@"物流公司:%@",order.expressCompany.length > 0?order.expressCompany : @""];
    self.orderPastHeaderPostIdContent.text = @"快递单号:";
    self.orderPastHeaderPostIdContentValue.text = [NSString stringWithFormat:@"%@",order.trackingNum.length > 0?order.trackingNum:@""];
    
    
    
}

- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    self.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 9999);
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.orderPastHeaderCompanyContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.top.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(47);
        make.width.mas_lessThanOrEqualTo([UIScreen mainScreen].bounds.size.width/2 -16);
        
    }];
    
    [self.orderPastHeaderPostIdContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf.contentView).offset([UIScreen mainScreen].bounds.size.width/2);
        make.top.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(47);
        make.width.equalTo(@65);
    }];
    
    [self.orderPastHeaderPostIdContentValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.orderPastHeaderPostIdContent.mas_trailing);
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.trailing.equalTo(weakSelf.contentView.mas_trailing).offset(-16);
    }];
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
        make.top.equalTo(weakSelf.orderPastHeaderPostIdContentValue.mas_bottom).offset(10);
        
    }];
    
    [self.orderPastHeaderContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.orderPastHeaderCompanyContent);
        make.top.equalTo(weakSelf.middleLineView.mas_bottom);
        make.trailing.equalTo(weakSelf.contentView.mas_trailing).offset(-16);
        make.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(47);
        
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
}


#pragma mark -



@end
