//
//  TopButton.m
//  VSProject
//
//  Created by certus on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "TopButton.h"

@implementation TopButton

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = _COLOR_CLEAR;

        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50/3, (144/3-20)/2, 16, 20)];
        _topImageView.backgroundColor = _COLOR_CLEAR;
        [self addSubview:_topImageView];
        
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(OffSetX(_topImageView)+20, 0, 100, 144/3)];
        _topLabel.backgroundColor = [UIColor clearColor];
        _topLabel.textAlignment =NSTextAlignmentLeft;
        _topLabel.textColor = _COLOR_HEX(0x282828);
        _topLabel.font = FONT_TITLE(15);
        _topLabel.text = @"我的订单";
        [self addSubview:_topLabel];
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(GetWidth(self)-50/3-7, (144/3-13)/2, 7, 13)];
        arrow.image = [UIImage imageNamed:@"usercenter_08"];
        arrow.backgroundColor = _COLOR_CLEAR;
        [self addSubview:arrow];
        
        _topSubLabel = [[UILabel alloc] initWithFrame:CGRectMake(arrow.frame.origin.x-54/3-100, 0, 100, 144/3)];
        _topSubLabel.backgroundColor = [UIColor clearColor];
        _topSubLabel.textAlignment =NSTextAlignmentRight;
        _topSubLabel.textColor = _COLOR_HEX(0x999999);
        _topSubLabel.font = FONT_TITLE(13);
        _topSubLabel.text = @"查看全部订单";
        [self addSubview:_topSubLabel];
        
        //line
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, GetWidth(self), 1)];
        line.backgroundColor = _COLOR_HEX(0xdfdfdf);
        [self addSubview:line];

        UILabel *buttomline = [[UILabel alloc] initWithFrame:CGRectMake(0, GetHeight(self)-1, GetWidth(self), 1)];
        buttomline.backgroundColor = _COLOR_HEX(0xdfdfdf);
        [self addSubview:buttomline];

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
