//
//  NearProjectTableViewCell.m
//  VSProject
//
//  Created by pangchao on 17/6/27.
//  Copyright © 2017年 user. All rights reserved.
//

#import "NearProjectTableViewCell.h"

@interface NearProjectTableViewCell ()

@property (nonatomic, strong) UIImageView *projectImageView;

@property (nonatomic, strong) UIView *blackView;

@property (nonatomic, strong) UILabel *projectNameLabel;

@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UIView *spaceView;
@property (nonatomic, strong) UILabel *distanceLabel;

@end

@implementation NearProjectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.projectImageView];
        [self.contentView addSubview:self.blackView];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGSize distanceSize = [self.distanceLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]}];
    self.distanceLabel.frame = CGRectMake(MainWidth - distanceSize.width - Get750Width(68.0f), Get750Width(23.0f), distanceSize.width, Get750Width(26.0f));
    
    self.spaceView.frame = CGRectMake(self.distanceLabel.frame.origin.x - Get750Width(6.0f), Get750Width(23.0f), 1.0f, Get750Width(26.0f));
    
    CGSize citySize = [ self.cityLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]}];
    self.cityLabel.frame = CGRectMake(MainWidth - Get750Width(68.0f) - distanceSize.width - Get750Width(11.0f) - citySize.width, Get750Width(23.0f), citySize.width, Get750Width(26.0f));
}

- (void)setDataSource:(Project *)data {
    
    self.project = data;
    
    if (self.project) {
        
        [self.projectImageView sd_setImageWithURL:[NSURL URLWithString:self.project.picture] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"]];
        
        self.projectNameLabel.text = self.project.projectName;
        self.cityLabel.text = self.project.city;
        self.distanceLabel.text = [NSString stringWithFormat:@"%.2fkm",self.project.distance.integerValue/1000.0];
    }
}

- (UIImageView *)projectImageView {
    
    if (!_projectImageView) {
        
        _projectImageView = [[UIImageView alloc] init];
        _projectImageView.frame = CGRectMake(Get750Width(24.0f), 0, MainWidth - Get750Width(48.0f), Get750Width(476.0f));
        _projectImageView.layer.masksToBounds = YES;
        _projectImageView.layer.cornerRadius = Get750Width(5.0f);
    }
    
    return _projectImageView;
}

- (UIView *)blackView {
 
    if (!_blackView) {
        _blackView = [[UIView alloc] init];
        [_blackView setBackgroundColor:ColorWithHex(0x000000, 0.5)];
        _blackView.frame = CGRectMake(Get750Width(24.0f), Get750Width(394.0f), MainWidth - Get750Width(48.0f), Get750Width(82.0f));
        [_blackView addSubview:self.projectNameLabel];
        [_blackView addSubview:self.cityLabel];
        [_blackView addSubview:self.spaceView];
        [_blackView addSubview:self.distanceLabel];
        
        _blackView.layer.masksToBounds = YES;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_blackView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(2.5f, 2.5f)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _blackView.bounds;
        maskLayer.path = maskPath.CGPath;
        _blackView.layer.mask = maskLayer;
    }
    return _blackView;
}

- (UILabel *)projectNameLabel {
    
    if (!_projectNameLabel) {
        
        _projectNameLabel = [[UILabel alloc] init];
        _projectNameLabel.frame = CGRectMake(Get750Width(30.0f), Get750Width(25.0f), Get750Width(450.0f), Get750Width(32.0f));
        _projectNameLabel.font = FONT_TITLE(16.0f);
        _projectNameLabel.textColor = _Colorhex(0xefeff4);
        _projectNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _projectNameLabel;
}

- (UILabel *)cityLabel {
    
    if (!_cityLabel) {
        
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.frame = CGRectMake(MainWidth - Get750Width(210.0f), Get750Width(23.0f), Get750Width(80.0f), Get750Width(26.0f));
        _cityLabel.font = FONT_TITLE(13.0f);
        _cityLabel.textColor = _Colorhex(0xefeff4);
        _cityLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _cityLabel;
}

- (UIView *)spaceView {
    
    if (!_spaceView) {
        
        _spaceView = [[UIView alloc] init];
        _spaceView.frame = CGRectMake(self.cityLabel.frame.origin.x + self.cityLabel.frame.size.width + Get750Width(5.0f), Get750Width(23.0f), 1.0f, Get750Width(26.0f));
        _spaceView.backgroundColor = _Colorhex(0xefeff4);
    }
    
    return _spaceView;
}

- (UILabel *)distanceLabel {
    
    if (!_distanceLabel) {
        
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.frame = CGRectMake(MainWidth - Get750Width(130.0f), Get750Width(23.0f), Get750Width(80.0f), Get750Width(26.0f));
        _distanceLabel.font = FONT_TITLE(13.0f);
        _distanceLabel.textColor = _Colorhex(0xefeff4);
        _distanceLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _distanceLabel;
}

@end
