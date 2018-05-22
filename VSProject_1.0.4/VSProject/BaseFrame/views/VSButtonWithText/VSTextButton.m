//
//  VSTextButton.m
//  VSProject
//
//  Created by bestjoy on 15/1/23.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSTextButton.h"

@implementation VSTextButton
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.button=[VSButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(self.button.mas_width).offset(10);
        }];
        [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        self.label=_ALLOC_OBJ_(VSLabel);
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(self.button.mas_bottom).offset(5);
            make.right.equalTo(@0);
            make.height.equalTo(@18);
        }];
        self.label.textAlignment=NSTextAlignmentCenter;
        _SETLABEL_STYLE(self.label, 12, _Colorhex(0x6c6c6c), @"");
        
    }
    return self;
}
-(void)setText:(NSString *)text
{
    self.label.text=text;
}
-(void)setImage:(UIImage *)image
{
    [self.button setImage:image forState:UIControlStateNormal];
}
-(void)buttonClick:(id)sender
{
    if ([_delegate respondsToSelector:@selector(addWithSelector:)])
    {
        [self.delegate performSelector:@selector(addWithSelector:) withObject:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
