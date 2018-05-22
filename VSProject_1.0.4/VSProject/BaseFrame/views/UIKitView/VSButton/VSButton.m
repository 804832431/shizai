//
//  VSButton.m
//  VSProject
//
//  Created by user on 15/1/20.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSButton.h"

@implementation VSButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    VSButton *btn = [super buttonWithType:buttonType];
    
    if([btn respondsToSelector:@selector(vp_setInit)])
    {
        [btn vp_setInit];
    }
    
    return btn;
}

- (void)vp_setInit
{
    _CLEAR_BACKGROUND_COLOR_(self);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
