//
//  HomeHeaderView.m
//  VSProject
//
//  Created by apple on 12/27/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView ()

_PROPERTY_NONATOMIC_STRONG(UIImageView, iconImageView)
_PROPERTY_NONATOMIC_STRONG(UILabel, titleLabel)
_PROPERTY_NONATOMIC_STRONG(UIButton, moreButton)
_PROPERTY_NONATOMIC_STRONG(UIView, topLineView)

@end

@implementation HomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.moreButton];
    [self addSubview:self.topLineView];
    return self;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, 0.5)];
        [_topLineView setBackgroundColor:ColorWithHex(0xf5f5f5, 1.0)];
    }
    return _topLineView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 15, 15)];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(27 + 6, 15, 100, 15)];
        [_titleLabel setTextColor:_Colorhex(0x302f37)];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _titleLabel;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 50 - 13, 17, 50, 15)];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [_moreButton setTitle:@"更多" forState:UIControlStateHighlighted];
        [_moreButton setTitleColor:_Colorhex(0x302f37) forState:UIControlStateNormal];
        [_moreButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_moreButton.titleLabel setTextAlignment:NSTextAlignmentRight];
        [_moreButton addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (void)moreAction {
    if (self.moreActionBlock) {
        self.moreActionBlock();
    }
}

- (void)setTitle:(NSString *)title
        withMore:(BOOL)shouldHaveMoreButton {
    [self.iconImageView setImage:__IMAGENAMED__(title)];
    [self.titleLabel setText:title];
    
    if (shouldHaveMoreButton) {
        [self.moreButton setHidden:NO];
    } else {
        [self.moreButton setHidden:YES];
    }
}

@end
