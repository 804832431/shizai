//
//  CenterButton.m
//  VSProject
//
//  Created by certus on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CenterButton.h"

@implementation CenterButton

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = _COLOR_CLEAR;

        _buttonImageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-20)/2, 40/3, 20, 18)];
        _buttonImageView.backgroundColor = _COLOR_CLEAR;
        [self addSubview:_buttonImageView];

        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake((frame.size.width-20)/2, 40/3, 20, 18)];
        _countLabel.textAlignment =NSTextAlignmentCenter;
        _countLabel.textColor = _COLOR_HEX(0x666666);
        _countLabel.font = FONT_TITLE(16);
        [self addSubview:_countLabel];
        
        _buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, OffSetY(_buttonImageView)+22/3, frame.size.width, 20)];
        _buttonLabel.backgroundColor = [UIColor clearColor];
        _buttonLabel.textAlignment =NSTextAlignmentCenter;
        _buttonLabel.textColor = _COLOR_HEX(0x666666);
        _buttonLabel.font = FONT_TITLE(12);
        _buttonLabel.text = @"我的订单";
        [self addSubview:_buttonLabel];
        
        _superscriptLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2+5, 3, 15, 15)];
        _superscriptLabel.backgroundColor = _Colorhex(0xfe9e49);
        _superscriptLabel.layer.cornerRadius = 7.5f;
        _superscriptLabel.clipsToBounds = YES;
        _superscriptLabel.textAlignment =NSTextAlignmentCenter;
        _superscriptLabel.textColor = [UIColor whiteColor];
        _superscriptLabel.font = FONT_TITLE(8);
        _superscriptLabel.text = @"0";
        [self addSubview:_superscriptLabel];


    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
