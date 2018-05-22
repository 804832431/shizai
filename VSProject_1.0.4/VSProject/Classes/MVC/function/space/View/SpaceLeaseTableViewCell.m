//
//  SpaceLeaseTableViewCell.m
//  VSProject
//
//  Created by pangchao on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpaceLeaseTableViewCell.h"
#import "SpaceListModel.h"

@implementation SpaceLeaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.roomInfoLabel];
        [self.contentView addSubview:self.singlePriceLabel];
        [self.contentView addSubview:self.bottomLine];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

+ (CGFloat)getHeight {
    
    return 107.5f;
}

- (void)setModel:(SpaceListModel *)model {
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.picListUrl] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"] options:SDWebImageUnCached];
    
    self.titleLabel.text = model.title;
//    CGRect rect = self.titleLabel.frame;
//    [self.titleLabel sizeToFit];
//    rect.size.height = self.titleLabel.frame.size.height;
//    self.titleLabel.frame = rect;
    
    self.roomInfoLabel.text = model.roomInfo;
    
    self.singlePriceLabel.text = model.singlePrice;
}

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake(12.0f, 7.5f, 110.0f, 85.0f);
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + 12.0f, 12.5f, MainWidth - 12.0f*2 - self.iconImageView.frame.size.width - 12.0f, 40);
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = _COLOR_HEX(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)roomInfoLabel {
 
    if (!_roomInfoLabel) {
        _roomInfoLabel = [[UILabel alloc] init];
        _roomInfoLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, 100.0f - 35.0f, self.titleLabel.frame.size.width, 11.0f);
        _roomInfoLabel.font = [UIFont systemFontOfSize:11.0f];
        _roomInfoLabel.textColor = _COLOR_HEX(0x9e9e9e);
        _roomInfoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _roomInfoLabel;
}

- (UILabel *)singlePriceLabel {
    
    if (!_singlePriceLabel) {
        _singlePriceLabel = [[UILabel alloc] init];
        _singlePriceLabel.frame = CGRectMake(self.roomInfoLabel.frame.origin.x, 100.0f - 20.0f, self.roomInfoLabel.frame.size.width, 12.0f);
        _singlePriceLabel.font = [UIFont systemFontOfSize:12.0f];
        _singlePriceLabel.textColor = _COLOR_HEX(0xff9c6b);
        _singlePriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _singlePriceLabel;
}

- (UIView *)bottomLine {
    
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.frame = CGRectMake(0, 100.0f, MainWidth, 7.5f);
        _bottomLine.backgroundColor = _COLOR_HEX(0xf3f3f3);
    }
    return _bottomLine;
}

@end
