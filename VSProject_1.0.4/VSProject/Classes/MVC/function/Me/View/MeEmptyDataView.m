//
//  MeEmptyDataView.m
//  VSProject
//
//  Created by pangchao on 16/12/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MeEmptyDataView.h"

@implementation MeEmptyDataView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = _COLOR_HEX(0xf1f1f1);
        [self addSubview:self.iconImageView];
        [self addSubview:self.tipsLabel];
    }
    return self;
}

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake((MainWidth - 396.0f/2)/2, 145.0f/2, 396.0f/2, 378.0f/2);
        _iconImageView.image = [UIImage imageNamed:@"me_orderempty_icon"];
    }
    return _iconImageView;
}

- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipsLabel.font = [UIFont systemFontOfSize:12.0f];
        _tipsLabel.textColor = _COLOR_HEX(0x999999);
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.text = @"暂无相关数据哦！";
        
        [_tipsLabel sizeToFit];
        CGRect fitRect = CGRectMake((MainWidth - _tipsLabel.frame.size.width)/2, self.iconImageView.frame.origin.y + self.iconImageView.frame.size.height + 36.0f, _tipsLabel.frame.size.width, 12.0f);
        _tipsLabel.frame = fitRect;
    }
    return _tipsLabel;
}

@end
