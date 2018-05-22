//
//  SpaceLeaseListCell.m
//  VSProject
//
//  Created by pangchao on 2017/10/23.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpaceLeaseListCell.h"
#import "SpaceProjectModel.h"

@interface SpaceLeaseListCell ()

@property (nonatomic, strong) UIImageView *spaceImageView; // 区域图片

@property (nonatomic, strong) UILabel *projectNameLabel; // 项目名称
@property (nonatomic, strong) UIView *spaceNameView; // 商圈名称背景
@property (nonatomic, strong) UILabel *spaceNameLabel; // 商圈名称

@property (nonatomic, strong) UIImageView *busIconImageView; // 公交车标记
@property (nonatomic, strong) UILabel *distanceBusLabel; // 距离公交站距离

@property (nonatomic, strong) UILabel *unitPriceLabel; // 单价
@property (nonatomic, strong) UILabel *unitLabel; // 单位
@property (nonatomic, strong) UILabel *minLabel; // xx 起

@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation SpaceLeaseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.contentView addSubview:self.spaceImageView];
        [self.contentView addSubview:self.projectNameLabel];
        [self.contentView addSubview:self.spaceNameView];
        [self.contentView addSubview:self.busIconImageView];
        [self.contentView addSubview:self.distanceBusLabel];
        [self.contentView addSubview:self.unitPriceLabel];
        [self.contentView addSubview:self.unitLabel];
        [self.contentView addSubview:self.minLabel];
        [self.contentView addSubview:self.bottomLineView];
    }

    return self;
}

- (void)setDataSource:(SpaceProjectModel *)spaceProjectModel {
    
    self.spaceProjectModel = spaceProjectModel;
    
    [self.spaceImageView sd_setImageWithURL:[NSURL URLWithString:spaceProjectModel.projectUrl] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"] options:SDWebImageUnCached];
    self.projectNameLabel.text = spaceProjectModel.title;
    self.spaceNameLabel.text = spaceProjectModel.areaInfo;
    self.distanceBusLabel.text = spaceProjectModel.trafficInfo;
    self.unitPriceLabel.text = spaceProjectModel.singlePrice;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 如果商业圈没有则不展示
    if ([self.spaceNameLabel.text isEmptyString] || self.spaceNameLabel.text == nil) {
        self.spaceNameView.hidden = YES;
    }
    else {
        self.spaceNameView.hidden = NO;
    }
    
    [self.unitPriceLabel sizeToFit];
    CGSize size = self.unitPriceLabel.frame.size;
    self.unitPriceLabel.frame = CGRectMake(MainWidth - Get750Height(64.0f) - size.width, Get750Height(92.0f), size.width, 20.0f);
    
    [self.spaceNameLabel sizeToFit];
    self.spaceNameView.frame = CGRectMake(self.projectNameLabel.frame.origin.x, self.projectNameLabel.frame.origin.y + self.projectNameLabel.frame.size.height + Get750Height(28.0f), self.spaceNameLabel.frame.size.width + 8.0f, Get750Height(40.0f));
}

- (UIImageView *)spaceImageView {
    
    if (!_spaceImageView) {
        
        _spaceImageView = [[UIImageView alloc] init];
        _spaceImageView.frame = CGRectMake(Get750Width(24.0f), Get750Width(22.0f), Get750Width(240.0f), Get750Width(180.0f));
        _spaceImageView.image = [UIImage imageNamed:@"usercenter_defaultpic"];
    }
    return _spaceImageView;
}

- (UILabel *)projectNameLabel {
    
    if (!_projectNameLabel) {
        
        _projectNameLabel = [[UILabel alloc] init];
        _projectNameLabel.frame = CGRectMake(self.spaceImageView.frame.origin.x + self.spaceImageView.frame.size.width + Get750Width(32.0f), Get750Width(40.0f), MainWidth - Get750Width(24.0f * 2 + 32.0f) - self.spaceImageView.frame.size.width, Get750Width(34.0f));
        _projectNameLabel.textColor = _Colorhex(0x302F35);
        _projectNameLabel.font = [UIFont systemFontOfSize:17.0f];
        _projectNameLabel.textAlignment = NSTextAlignmentLeft;
        _projectNameLabel.text = @"绿地环球文化金融城";
    }
    return _projectNameLabel;
}

- (UIView *)spaceNameView {
    
    if (!_spaceNameView) {
        
        _spaceNameView = [[UIView alloc] init];
        _spaceNameView.frame = CGRectMake(self.projectNameLabel.frame.origin.x, self.projectNameLabel.frame.origin.y + self.projectNameLabel.frame.size.height + Get750Height(28.0f), self.projectNameLabel.frame.size.width, Get750Height(40.0f));
        _spaceNameView.backgroundColor = _Colorhex(0x95DDF7);
        _spaceNameView.layer.borderColor = _Colorhex(0x95DDF7).CGColor;
        _spaceNameView.layer.cornerRadius = 2.0f;
        _spaceNameView.layer.borderWidth = 1.0f;
        _spaceNameView.layer.masksToBounds = YES;
        
        [_spaceNameView addSubview:self.spaceNameLabel];
    }
    return _spaceNameView;
}

- (UILabel *)spaceNameLabel {
    
    if (!_spaceNameLabel) {
        
        _spaceNameLabel = [[UILabel alloc] init];
        _spaceNameLabel.frame = CGRectMake(4.0f, 4.5f, 100.0f, Get750Height(22.0f));
        _spaceNameLabel.textColor = _Colorhex(0xFFFFFF);
        _spaceNameLabel.textAlignment = NSTextAlignmentCenter;
        _spaceNameLabel.font = [UIFont systemFontOfSize:11.0f];
        _spaceNameLabel.text = @"石景山 古城";
    }
    return _spaceNameLabel;
}

- (UIImageView *)busIconImageView {
    
    if (!_busIconImageView) {
        
        _busIconImageView = [[UIImageView alloc] init];
        _busIconImageView.frame = CGRectMake(self.spaceNameView.frame.origin.x, self.spaceNameView.frame.origin.y + self.spaceNameView.frame.size.height + Get750Height(26.0f), Get750Height(22.0f), Get750Height(26.0f));
        _busIconImageView.image = [UIImage imageNamed:@"bus_icon"];
    }
    return _busIconImageView;
}

- (UILabel *)distanceBusLabel {
    
    if (!_distanceBusLabel) {
        
        _distanceBusLabel = [[UILabel alloc] init];
        _distanceBusLabel.frame = CGRectMake(self.busIconImageView.frame.origin.x + self.busIconImageView.frame.size.width + Get750Height(14.0f), self.spaceNameView.frame.origin.y + self.spaceNameView.frame.size.height + Get750Height(28.0f), MainWidth - Get750Width(24.0f * 2 + 32.0f + 36.0f) - self.spaceImageView.frame.size.width, Get750Width(22.0f));
        _distanceBusLabel.alpha = 0.8f;
        _distanceBusLabel.textColor = _Colorhex(0x302F35);
        _distanceBusLabel.font = [UIFont systemFontOfSize:11.0f];
        _distanceBusLabel.textAlignment = NSTextAlignmentLeft;
        _distanceBusLabel.text = @"距1号古城站100米";
    }
    return _distanceBusLabel;
}
   
- (UILabel *)unitPriceLabel{
 
    if (!_unitPriceLabel) {
        
        _unitPriceLabel = [[UILabel alloc] init];
        _unitPriceLabel.frame = CGRectMake(MainWidth - Get750Height(64.0f) - 40.0f, Get750Height(92.0f), 40.0f, 20.0f);
        _unitPriceLabel.textColor = _Colorhex(0xFF9600);
        _unitPriceLabel.font = [UIFont systemFontOfSize:20.0f];
        _unitPriceLabel.textAlignment = NSTextAlignmentRight;
        _unitPriceLabel.text = @"4.5";
    }
    return _unitPriceLabel;
}
   
- (UILabel *)unitLabel {
    
    if (!_unitLabel) {
     
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.frame = CGRectMake(MainWidth - Get750Width(64.0f + 80.0f), [SpaceLeaseListCell getHeight] - Get750Width(72.0f) - 10.0f, Get750Width(80.0f), 10.0f);
        _unitLabel.font = [UIFont systemFontOfSize:10.0f];
        _unitLabel.textColor = _Colorhex(0xFF9600);
        _unitLabel.textAlignment = NSTextAlignmentRight;
        _unitLabel.text = @"元/㎡/天";
    }
    
    return _unitLabel;
}
   
- (UILabel *)minLabel {
    
    if (!_minLabel) {
        
        _minLabel = [[UILabel alloc] init];
        _minLabel.frame = CGRectMake(MainWidth - Get750Width(30.0f) - 10.0f, Get750Width(124.0f), 10.0f, 11.0f);
        _minLabel.font = [UIFont systemFontOfSize:11.0f];
        _minLabel.textColor = _Colorhex(0x87878A);
        _minLabel.textAlignment = NSTextAlignmentRight;
        _minLabel.text = @"起";
    }
    
    return _minLabel;
}

- (UIView *)bottomLineView {
    
    if (!_bottomLineView) {
        
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.frame = CGRectMake(self.spaceImageView.frame.origin.x, [SpaceLeaseListCell getHeight] - 1.0f, MainWidth - Get750Width(24.0f * 2), 1.0f);
        _bottomLineView.backgroundColor = _Colorhex(0xF3F3F3);
    }
    return _bottomLineView;
}

+ (CGFloat)getHeight {
    
    return Get750Width(224.0f);
}
   
@end
