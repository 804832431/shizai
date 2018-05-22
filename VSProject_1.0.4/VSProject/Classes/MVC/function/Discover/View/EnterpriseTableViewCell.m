//
//  EnterpriseTableViewCell.m
//  VSProject
//
//  Created by pangchao on 16/12/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "EnterpriseTableViewCell.h"
#import "EnterpriseModel.h"

@implementation EnterpriseTableViewCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.backgroundImageVIew];
        [self.contentView addSubview:self.blackClearView];
    }
    return self;
}

- (UIView *)blackClearView {
    
    if (!_blackClearView) {
        _blackClearView = [[UIView alloc] init];
        [_blackClearView setBackgroundColor:ColorWithHex(0x000000, 0.5)];
        _blackClearView.frame = CGRectMake(Get750Width(24.0f), Get750Width(394.0f + 24.0f), MainWidth - Get750Width(48.0f), Get750Width(82.0f));
        [_blackClearView addSubview:self.enterpriseNameLabel];
        
        _blackClearView.layer.masksToBounds = YES;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_blackClearView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(2.5f, 2.5f)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _blackClearView.bounds;
        maskLayer.path = maskPath.CGPath;
        _blackClearView.layer.mask = maskLayer;
    }
    return _blackClearView;
}

- (UIImageView *)backgroundImageVIew {
    
    if (!_backgroundImageVIew) {
        _backgroundImageVIew = [[UIImageView alloc] init];
        _backgroundImageVIew.frame = CGRectMake(Get750Width(24.0f), Get750Width(24.0f), MainWidth - Get750Width(48.0f), Get750Width(476.0f));
        
        _backgroundImageVIew.layer.masksToBounds = YES;
        _backgroundImageVIew.layer.borderWidth = 1.0f;
        _backgroundImageVIew.layer.borderColor = [UIColor clearColor].CGColor;
        _backgroundImageVIew.layer.cornerRadius = 2.5f;
    }
    return _backgroundImageVIew;
}

- (UIImageView *)logoImageView {
    
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.frame = CGRectMake((MainWidth - 150.0f)/2, 40.0f, 150.0f, 50.0f);
    }
    return _logoImageView;
}

- (UILabel *)enterpriseNameLabel {
    
    if (!_enterpriseNameLabel) {
        _enterpriseNameLabel = [[UILabel alloc] init];
        _enterpriseNameLabel.frame = CGRectMake(Get750Width(30.0f), Get750Width(25.0f), MainWidth - Get750Width(60.0f), Get750Width(32.0f));
        _enterpriseNameLabel.font = [UIFont systemFontOfSize:16.0f];
        _enterpriseNameLabel.textColor = _COLOR_HEX(0xffffff);
        _enterpriseNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _enterpriseNameLabel;
}

- (UIView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.frame = CGRectMake(0, Get750Width(476.0f), MainWidth, 5.0f);
        _bottomView.backgroundColor = _COLOR_HEX(0xf3f3f3);
    }
    return _bottomView;
}

- (void)setModel:(EnterpriseModel *)model {
    
    [self.backgroundImageVIew sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"] options:SDWebImageUnCached];
    
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageUnCached];
    
    self.enterpriseNameLabel.text = model.name;
}

@end
