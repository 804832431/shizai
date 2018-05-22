//
//  NearNewTableViewCell.m
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import "NearNewTableViewCell.h"
#import "NearNewProduct.h"

#define cellheight     100.0f + 5.0f

@implementation NearNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.adImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.companyLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.orderNumLabel];
    }
    return self;
}

- (void)setData:(NearNewProduct *)product {
    
    [self.adImageView sd_setImageWithURL:[NSURL URLWithString:product.smallImageUrl] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"] options:SDWebImageUnCached];
    self.titleLabel.text = product.productName;
    self.companyLabel.text = product.merchantName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", product.price];
    NSString *orderNum = [NSString stringWithFormat:@"已成交%@笔", product.dealedCount];
    self.orderNumLabel.text = orderNum;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.frame = CGRectMake(0, 100.0f, MainWidth, 5.0f);
        _lineView.backgroundColor = _COLOR_HEX(0xdedede);
    }
    return _lineView;
}

- (UIImageView *)adImageView {
    
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] init];
        _adImageView.frame = CGRectMake(12.0f, (100.0f - 84.5f)/2, 110.0f, 84.5f);
    }
    return _adImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(self.adImageView.frame.origin.x + self.adImageView.frame.size.width + 20.0f, 10.0f, MainWidth - 12.0f*2 - 20.0f - self.adImageView.frame.size.width, 20.0f);
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.textColor = _Colorhex(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)companyLabel {
    
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10.0f, self.titleLabel.frame.size.width, 20.0f);
        _companyLabel.font = [UIFont systemFontOfSize:12.0f];
        _companyLabel.textColor = _Colorhex(0x999999);
        _companyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _companyLabel;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.adImageView.frame.origin.y + self.adImageView.frame.size.height - 5 - 12.0f, 100.0f, 12.0f);
        _priceLabel.font = [UIFont systemFontOfSize:12.0f];
        _priceLabel.textColor = _Colorhex(0xff8a00);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLabel;
}

- (UILabel *)orderNumLabel {
    
    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc] init];
        _orderNumLabel.frame = CGRectMake(MainWidth - 12.0f - 100.0f, self.priceLabel.frame.origin.y, 100.0f, 12.0f);
        _orderNumLabel.font = [UIFont systemFontOfSize:12.0f];
        _orderNumLabel.textColor = _Colorhex(0x999999);
        _orderNumLabel.textAlignment = NSTextAlignmentRight;
    }
    return _orderNumLabel;
}

@end
