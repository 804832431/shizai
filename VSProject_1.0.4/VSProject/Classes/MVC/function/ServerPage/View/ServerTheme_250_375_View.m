//
//  ServerTheme_250_375_View.m
//  VSProject
//
//  Created by pangchao on 17/6/25.
//  Copyright © 2017年 user. All rights reserved.
//

#import "ServerTheme_250_375_View.h"
#import "TopicProductDTO.h"

@interface ServerTheme_250_375_View ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIView *rightLineView;

@property (nonatomic, strong) UIImageView *themeImageView;

@end

@implementation ServerTheme_250_375_View

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        [self addSubview:self.titleLabel];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.themeImageView];
        [self addSubview:self.rightLineView];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedAction:)];
        [self addGestureRecognizer:recognizer];
    }
    
    return self;
}

- (void)setData:(TopicProductDTO *)dto {
    
    if (self.topicProductDTO) {
        if (![self.topicProductDTO.photo isEqualToString:dto.photo]) {
            [self.themeImageView sd_setImageWithURL:[NSURL URLWithString:dto.photo] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"] options:SDWebImageUnCached];
        }
    }
    else {
        [self.themeImageView sd_setImageWithURL:[NSURL URLWithString:dto.photo] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"] options:SDWebImageUnCached];
    }
    
    self.titleLabel.text = dto.mainTitle;
    
    self.tipsLabel.text = dto.subTile;
    
    self.topicProductDTO = dto;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(Get750Height(22.0f), Get750Width(42.0f), Get750Width(500.0f - 44.0f), Get750Width(36.0f));
        _titleLabel.font = FONT_TITLE(18.0f);
        _titleLabel.textColor = _COLOR_HEX(0x302f37);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + Get750Width(12.0f), self.titleLabel.frame.size.width, Get750Width(28.0f));
        _tipsLabel.font = FONT_TITLE(14.0f);
        _tipsLabel.textColor = _Colorhex(0x999999);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _tipsLabel;
}

- (UIImageView *)themeImageView {
    
    if (!_themeImageView) {
        
        _themeImageView = [[UIImageView alloc] init];
        _themeImageView.frame = CGRectMake(0, Get750Width(187.0f), Get750Width(250.0f), Get750Width(188.0f));
    }
    
    return _themeImageView;
}

- (void)clickedAction:(UITapGestureRecognizer *)recognizer {
    
    if (self.delegate) {
        [self.delegate topic_250_375_ClickedAction:self.topicProductDTO];
    }
}

- (UIView *)rightLineView {
    
    if (!_rightLineView) {
        
        _rightLineView = [[UIView alloc] init];
        _rightLineView.frame = CGRectMake(Get750Width(249.0f), 0, Get750Width(1.0f), Get750Width(375.0f));
        _rightLineView.backgroundColor = _Colorhex(0xefeff4);
    }
    
    return _rightLineView;
}

@end
