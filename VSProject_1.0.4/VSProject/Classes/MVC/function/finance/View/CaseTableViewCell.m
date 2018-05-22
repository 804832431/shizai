//
//  CaseTableViewCell.m
//  VSProject
//
//  Created by pangchao on 17/1/5.
//  Copyright © 2017年 user. All rights reserved.
//

#import "CaseTableViewCell.h"
#import "NewsModel.h"

@implementation CaseTableViewCell

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
        [self.contentView addSubview:self.introductionLabel];
    }
    return self;
}

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake(12.0f, (100.0f - 85.0f)/2, 110.0f, 85.0f);
    }
    return _iconImageView;
}

- (UILabel *)introductionLabel {
    
    if (!_introductionLabel) {
        _introductionLabel = [[UILabel alloc] init];
        _introductionLabel.frame = CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + 20.0f, 20.0f, MainWidth - 12.0f*2 - 10.0f - self.iconImageView.frame.size.width, 80.0f);
        _introductionLabel.font = [UIFont systemFontOfSize:14.0f];
        _introductionLabel.textColor = _Colorhex(0x333333);
        _introductionLabel.textAlignment = NSTextAlignmentLeft;
        _introductionLabel.numberOfLines = 0;
    }
    return _introductionLabel;
}

- (void)setModel:(NewsModel *)model {
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"] options:SDWebImageUnCached];
    self.introductionLabel.text = model.title;
    CGRect rect = self.introductionLabel.frame;
    [self.introductionLabel sizeToFit];
    rect.size.height = self.introductionLabel.frame.size.height;
    self.introductionLabel.frame = rect;
}

@end
