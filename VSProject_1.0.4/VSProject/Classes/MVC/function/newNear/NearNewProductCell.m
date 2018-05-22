//
//  NearNewProductCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/29.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NearNewProductCell.h"

@implementation NearNewProductCell


- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = _Colorhex(0xcccccc);
    }
    return _bottomLineView;
}

- (UIImageView *)prodcutView{
    if (_prodcutView == nil) {
        _prodcutView = [UIImageView new];
    }
    return _prodcutView;
}

- (UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.font = [UIFont systemFontOfSize:10];
        _descriptionLabel.numberOfLines = 2;
        _descriptionLabel.textColor = _Colorhex(0x333333);
    }
    return _descriptionLabel;
}

- (UILabel *)companyLabel{
    if (_companyLabel == nil) {
        _companyLabel = [UILabel new];
        _companyLabel.font = [UIFont systemFontOfSize:9];
        _companyLabel.textColor = _Colorhex(0xa0a0a0);
    }
    return _companyLabel;
}

- (UILabel *)successOrderCountsLabel{
    if (_successOrderCountsLabel == nil) {
        _successOrderCountsLabel = [UILabel new];
        _successOrderCountsLabel.font = [UIFont systemFontOfSize:10];
        _successOrderCountsLabel.textColor = _Colorhex(0xa0a0a0);
    }
    return _successOrderCountsLabel;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.textColor = _Colorhex(0xeb5540);
        _priceLabel.font = [UIFont systemFontOfSize:16.5];
    }
    return _priceLabel;
}

-(UILabel *)oldPriceLabel{
    if (_oldPriceLabel == nil) {
        _oldPriceLabel = [UILabel new];
        _oldPriceLabel.font = [UIFont systemFontOfSize:10];
        _oldPriceLabel.textColor = _Colorhex(0xa0a0a0);
        
    }
    return _oldPriceLabel;
}

-(UIView *)oldAddLineView{
    if (_oldAddLineView == nil) {
        _oldAddLineView = [UILabel new];
        _oldAddLineView.backgroundColor = _Colorhex(0xa0a0a0);
    }
    return _oldAddLineView;
}

-(UILabel *)scoreLabel{
    if (_scoreLabel == nil) {
        _scoreLabel = [UILabel new];
        _scoreLabel.textColor = _RGB_A(255, 150, 0, 1);
        _scoreLabel.font = [UIFont systemFontOfSize:9];
    }
    return _scoreLabel;
}

//优惠 折  减  送 免
-(NSArray *)promotionTypeImageViews
{
    if (_promotionTypeImageViews == nil) {
        
        UIImageView *v1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"最新产品－折－icon"]];
        UIImageView *v2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"最新产品－减－icon"]];
        UIImageView *v3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"最新产品－送－icon"]];
        UIImageView *v4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"最新产品－免－icon"]];
        
        _promotionTypeImageViews = @[v1,v2,v3,v4];
        
    }
    return _promotionTypeImageViews;
}

- (UIView *)promotionTypebackgroundView{
    if (_promotionTypebackgroundView == nil) {
        _promotionTypebackgroundView = [UIView new];
    }
    return _promotionTypebackgroundView;
}

//几星等级
- (UIView *)starView{
    if (_starView == nil) {
        _starView = [[UIView alloc] init];
    }
    return _starView;
}



- (void)setProduct:(NearNewProduct *)product{
    
    _product = product;
    
    [self.prodcutView sd_setImageWithString:product.smallImageUrl placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"]];
    self.descriptionLabel.text = product.productName;
    self.companyLabel.text = product.merchantName;
    
    self.successOrderCountsLabel.text = [NSString stringWithFormat:@"成交%i笔",[product.dealedCount intValue]];
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2lf",[product.promotionPrice doubleValue] ];
    
    self.oldPriceLabel.text = [NSString stringWithFormat:@"¥%.2lf",[product.price doubleValue] ];
    
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1lf分",[product.avgEvaluation doubleValue]];
    
    
    [[self.promotionTypebackgroundView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    __weak typeof(self) weakSelf = self;
    
    UIView *preView = nil;
    
    NSArray *imageNames = @[@"最新产品－折－icon",@"最新产品－减－icon",@"最新产品－送－icon",@"最新产品－免－icon"];
    
    for (int i = 0;  i < 4; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNames[i]]];
        [self.promotionTypebackgroundView addSubview:imageView];
        
        imageView.hidden = YES;
        
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            for (PromotionType *promotionType in product.thepromotionTypes) {
                if (promotionType.promotionType.integerValue - 1 == i) {
                    imageView.hidden = NO;
                    make.size.mas_equalTo(CGSizeMake(17, 17));
                }
            }
            
            if (imageView.hidden == YES) {
                make.size.mas_equalTo(CGSizeMake(0, 17));
            }
            
            if (preView == nil) {
                make.leading.equalTo(weakSelf.promotionTypebackgroundView);
            }else if(preView.hidden == YES)
                make.leading.equalTo(preView.mas_trailing);
            else {
                make.leading.equalTo(preView.mas_trailing).offset(6);
            }
            
            make.top.equalTo(weakSelf.promotionTypebackgroundView);
        }];
        
        preView = imageView;
    }
    
    
    
    
    [[self.starView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    preView = nil;
    for (int i = 0;  i < 5; i++) {
        
        UIImageView *imageView = nil;
        
        if (i < product.avgEvaluation.floatValue) {
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"最新产品－星评1-icon"]];
        }else{
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"最新产品－星评2-icon"]];
        }
        
        
        [self.starView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (preView == nil) {
                make.leading.equalTo(weakSelf.promotionTypebackgroundView);
            }else{
                make.leading.equalTo(preView.mas_trailing).offset(2);
            }
            
            make.size.mas_equalTo(CGSizeMake(11, 10));
            make.top.equalTo(weakSelf.starView);
        }];
        
        preView = imageView;
    }
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.bottomLineView];
        [self.contentView addSubview:self.prodcutView];
        [self.contentView addSubview:self.descriptionLabel];
        [self.contentView addSubview:self.companyLabel];
        [self.contentView addSubview:self.successOrderCountsLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.oldPriceLabel];
        [self.contentView addSubview:self.oldAddLineView];
        [self.contentView addSubview:self.scoreLabel];
        
        [self.contentView addSubview:self.promotionTypebackgroundView];
        [self.contentView addSubview:self.starView];
        
        [self updateConstraintsForSubViews];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}


- (void)updateConstraintsForSubViews{
    
    __weak typeof(self) weakSelf = self;
    
    [self.prodcutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(12);
        make.top.equalTo(weakSelf.contentView).offset(8);
        make.size.mas_equalTo(CGSizeMake(90, 80));
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.prodcutView.mas_trailing).offset(6);
        make.top.equalTo(weakSelf.prodcutView);
        make.trailing.equalTo(weakSelf.contentView).offset(-12);
    }];
    
    [self.promotionTypebackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.descriptionLabel);
        make.top.equalTo(weakSelf.prodcutView).offset(25);
        make.width.equalTo(@100);
        make.height.mas_equalTo(17);
    }];
    
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.descriptionLabel);
        make.top.equalTo(weakSelf.promotionTypebackgroundView.mas_bottom).offset(5);
    }];
    
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.descriptionLabel);
        make.top.equalTo(weakSelf.companyLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(70, 11));
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.starView);
        make.leading.equalTo(weakSelf.starView.mas_trailing).offset(-2);
    }];
    
    
    [self.oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-10);
        make.trailing.equalTo(weakSelf.contentView).offset(-12);
    }];
    
    [self.oldAddLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.oldPriceLabel);
        make.width.leading.equalTo(weakSelf.oldPriceLabel);
        make.height.equalTo(@1);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.oldPriceLabel);
        make.bottom.equalTo(weakSelf.oldPriceLabel.mas_top).offset(-2);
        
    }];
    
    [self.successOrderCountsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.priceLabel);
        make.bottom.equalTo(weakSelf.priceLabel.mas_top).offset(-2);
    }];
}


@end































