//
//  MeTableViewCell.m
//  VSProject
//
//  Created by pangchao on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MeTableViewCell.h"

@implementation MeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.bottomLineView];
    }
    return self;
}

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake(Get750Width(30.0f), Get750Width(25.0f), Get750Width(58.0f), Get750Width(58.0f));
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + Get750Width(30.0f), Get750Width(38.0f), MainWidth - Get750Width(118.0f), Get750Width(34.0f));
        _titleLabel.font = [UIFont systemFontOfSize:17.0f];
        _titleLabel.textColor = _COLOR_HEX(0x302f35);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView {
    
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.frame = CGRectMake(MainWidth - Get750Width(50.0f + 14.0f), Get750Width(42.0f), Get750Width(14.0f), Get750Width(24.0f));
        _arrowImageView.backgroundColor = [UIColor clearColor];
    }
    return _arrowImageView;
}

- (UIView *)bottomLineView {
    
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.frame = CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width, Get750Width(108.0f), MainWidth, 0.5f);
        _bottomLineView.backgroundColor = _COLOR_HEX(0xeaeaea);
    }
    return _bottomLineView;
}

@end
