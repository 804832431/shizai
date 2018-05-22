//
//  MeSettingTableViewCell.m
//  VSProject
//
//  Created by pangchao on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MeSettingTableViewCell.h"

@implementation MeSettingTableViewCell

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
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.tipsLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews {
    
    CGRect titleRect = self.titleLabel.frame;
    [self.titleLabel sizeToFit];
    titleRect.size.width = self.titleLabel.frame.size.width;
    self.titleLabel.frame = titleRect;
    
    self.tipsLabel.frame = CGRectMake(self.titleLabel.frame.origin.x + GetWidth(self.titleLabel) + 10.0f, (CELL_HEIGHT - 13.0f)/2, 60.0f, 13.0f);
}

+ (CGFloat)getHeight {
    
    return CELL_HEIGHT;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(12.0f, (CELL_HEIGHT - 15.0f)/2, 100.0f, 15.0f);
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.textColor = _COLOR_HEX(0x212121);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.frame = CGRectMake(self.titleLabel.frame.origin.x + GetWidth(self.titleLabel) + 10.0f, (CELL_HEIGHT - 13.0f)/2, 60.0f, 13.0f);
        _tipsLabel.font = [UIFont systemFontOfSize:13.0f];
        _tipsLabel.textColor = _COLOR_HEX(0x333333);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tipsLabel;
}

- (UIImageView *)arrowImageView {
    
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.frame = CGRectMake(MainWidth - 12.0f - 9.0f, (CELL_HEIGHT - 17.0f)/2, 9.0f, 17.0f);
        _arrowImageView.image = [UIImage imageNamed:@"me_arrow"];
    }
    return _arrowImageView;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.frame = CGRectMake(0, CELL_HEIGHT - 0.5f, MainWidth, 0.5f);
        _lineView.backgroundColor = _COLOR_HEX(0xf3f3f3);
    }
    return _lineView;
}

@end
