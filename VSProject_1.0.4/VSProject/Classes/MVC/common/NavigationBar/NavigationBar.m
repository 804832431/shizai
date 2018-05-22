//
//  NavigationBar.m
//  VSProject
//
//  Created by certus on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithNavigationTitle:(NSString *)title buttonLeft1:(NSString *)left1Name buttonLeft2:(NSString *)left2Name buttonRight1:(NSString *)right1Name buttonRight2:(NSString *)right2Name{

    self = [super init];
    
    if (self) {
        self.frame = CGRectMake(0, 0, MainWidth, 64);
        self.backgroundColor = _COLOR_HEX(0x40464e);

        if (title) {
            _titleUIButton = [[UIButton alloc] initWithFrame:CGRectMake(64*2, 0, MainWidth-64*4, 84)];
            [_titleUIButton setTitle:title forState:UIControlStateNormal];
            [_titleUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self addSubview:_titleUIButton];
            [_titleUIButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).with.offset(-64*2);
                make.top.equalTo(self.mas_top);
                make.left.equalTo(self.mas_left).with.offset(64*2);
                make.height.equalTo(@84);
            }];

        }

        if (left1Name) {
            _buttonLeft1 = [UIButton buttonWithType:UIButtonTypeCustom];
            _buttonLeft1.frame = CGRectMake(0, 0, 64, 84);
            [_buttonLeft1 setImage:[UIImage imageNamed:left1Name] forState:UIControlStateNormal];
            [self addSubview:_buttonLeft1];
        }

        if (left2Name) {
            _buttonLeft2 = [UIButton buttonWithType:UIButtonTypeCustom];
            _buttonLeft2.frame = CGRectMake(64, 0, 64, 84);
            [_buttonLeft2 setImage:[UIImage imageNamed:left2Name] forState:UIControlStateNormal];
            [self addSubview:_buttonLeft2];
        }

        if (right1Name) {
            _buttonRight1 = [UIButton buttonWithType:UIButtonTypeCustom];
            _buttonRight1.frame = CGRectMake(MainWidth-64, 0, 64, 84);
            [_buttonRight1 setImage:[UIImage imageNamed:right1Name] forState:UIControlStateNormal];
            [self addSubview:_buttonRight1];
            [_buttonRight2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right);
                make.top.equalTo(self.mas_top);
                make.width.equalTo(@64);
                make.height.equalTo(@84);
            }];

            NSLog(@"_buttonRight1--%@",_buttonRight1);

        }
        if (right2Name) {
            _buttonRight2 = [UIButton buttonWithType:UIButtonTypeCustom];
            _buttonRight2.frame = CGRectMake(MainWidth-64*2, 0, 64, 84);
            [_buttonRight2 setImage:[UIImage imageNamed:right2Name] forState:UIControlStateNormal];
            [self addSubview:_buttonRight2];
        }
    }
    return self;
}

@end
