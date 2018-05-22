//
//  SpacePurchaseTableViewCell.m
//  VSProject
//
//  Created by pangchao on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpacePurchaseTableViewCell.h"
#import "SpaceListModel.h"

@implementation SpacePurchaseTableViewCell

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
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.contentView addSubview:self.backgroupImageView];
        [self.contentView addSubview:self.titleView];
    }
    return self;
}

- (UIImageView *)backgroupImageView {
    
    if (!_backgroupImageView) {
        _backgroupImageView = [[UIImageView alloc] init];
        _backgroupImageView.frame = CGRectMake(0, 0, MainWidth, 185.0f);
    }
    return _backgroupImageView;
}

- (UIView *)titleView {
    
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.frame = CGRectMake(0, 185.0f - 44.0f, MainWidth, 44.0f);
        _titleView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [_titleView addSubview:self.titleLabel];
    }
    return _titleView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(5.0f, 16.0f, MainWidth - 10.0f, 20.0f);
        _titleLabel.textColor = _COLOR_HEX(0xffffff);
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

+ (CGFloat)getHeight {
    
    return 185.0f;
}

- (void)setModel:(SpaceListModel *)model {
    
    [self.backgroupImageView sd_setImageWithURL:[NSURL URLWithString:model.picListUrl] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"] options:SDWebImageUnCached];
    
    self.titleLabel.text = model.title;
}

@end
