//
//  AccessoryView.m
//  EmperorComing
//
//  Created by certus on 15/8/25.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import "AccessoryView.h"

@implementation AccessoryView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
    self.backgroundColor=[UIColor whiteColor];
    
    if (self) {
        
        self.backgroundColor = _COLOR_HEX(0xeeeeee);
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(20, 7, 50, 28);
        [_cancelBtn setTitleColor:_COLOR_HEX(0x35b38d) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
        [_cancelBtn setHidden:NO];

        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(frame.size.width-28-40, 0, 68, frame.size.height);
        [_sureBtn setTitleColor:_COLOR_HEX(0x35b38d) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self addSubview:_sureBtn];

        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 6, frame.size.width-120, 30)];
        _titleLabel.numberOfLines = 1;
        _titleLabel.font =[UIFont boldSystemFontOfSize:20.f];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:_titleLabel];

        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];

        UIView *buttonLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-0.5, frame.size.width, 0.5)];
        buttonLine.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:buttonLine];

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
