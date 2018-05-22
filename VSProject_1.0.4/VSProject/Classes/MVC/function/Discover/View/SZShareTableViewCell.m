//
//  SZShareTableViewCell.m
//  VSProject
//
//  Created by pangchao on 16/12/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SZShareTableViewCell.h"
#import "PolicyModel.h"

@implementation SZShareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timelabel];
//        [self.contentView addSubview:self.bottomView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 计算文字占据的高度
    CGSize titleSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.titleLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
    
    if (titleSize.height > 40) {
        self.titleLabel.frame = CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + Get750Width(30.0f), Get750Width(52.0f), MainWidth - Get750Width(48.0f + 270.0f), titleSize.height);
    }
}

- (UIImageView *)iconImageView {
    
    if(!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake(Get750Width(24.0f), Get750Width(24.0f), Get750Width(240.0f), Get750Width(180.0f));
        
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.borderWidth = 0.0f;
        _iconImageView.layer.cornerRadius = 2.5f;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + Get750Width(30.0f), Get750Width(52.0f), MainWidth - Get750Width(48.0f + 270.0f), Get750Width(40.0f));
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textColor = _COLOR_HEX(0x302f35);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)timelabel {
    
    if(!_timelabel) {
        _timelabel = [[UILabel alloc] init];
        _timelabel.frame = CGRectMake(MainWidth - Get750Width(24.0f) - 100.0f, Get750Width(228.0f - 24.0f - 24.0f), 100.0f, Get750Width(24.0f));
        _timelabel.font = [UIFont systemFontOfSize:12.0f];
        _timelabel.textColor = _COLOR_HEX(0x302f37);
        _timelabel.alpha = 0.3f;
        _timelabel.textAlignment = NSTextAlignmentRight;
    }
    return _timelabel;
}

- (UIView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.frame = CGRectMake(0, Get750Width(228.0f), MainWidth, 5.0f);
        _bottomView.backgroundColor = _COLOR_HEX(0xf3f3f3);
    }
    return _bottomView;
}

- (void)setModel:(PolicyModel *)model {
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"] options:SDWebImageUnCached];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.title length])];
    self.titleLabel.attributedText = attributedString;
    
    long long time = [model.createTime longLongValue];
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    self.timelabel.text = [dateFormatter stringFromDate:date];
}

@end
