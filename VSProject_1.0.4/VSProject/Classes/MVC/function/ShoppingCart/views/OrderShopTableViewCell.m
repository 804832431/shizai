//
//  OrderShopTableViewCell.m
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import "OrderShopTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation OrderShopTableViewCell

- (UILabel *) topLineView{
    
    if (_topLineView == nil) {
        _topLineView = [UILabel new];
        _topLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    return _topLineView;
}

- (UILabel *)shopName{
    
    if (_shopName == nil) {
        _shopName = [UILabel new];
        _shopName.font = [UIFont systemFontOfSize:13];
        _shopName.textColor =[UIColor colorFromHexRGB:@"343434"];
    }
    
    return _shopName;
}

- (UILabel *) bottomLineView{
    
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
        [self.contentView addSubview:self.topLineView];
        [self.contentView addSubview:self.shopName];
        [self.contentView addSubview:self.bottomLineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubviews];
    }
    
    return self;
}

- (void)setCartInfoDTO:(ShoppingCartInfoDTO *)cartInfoDTO{
    _cartInfoDTO = cartInfoDTO;
    self.shopName.text = cartInfoDTO.categoryName;
}

- (void) updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
}

@end



















