//
//  VSView.m
//  VSProject
//
//  Created by user on 15/1/20.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSView.h"

@implementation VSView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        if([self respondsToSelector:@selector(vp_setInit)])
        {
            [self vp_setInit];
        }
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if([self respondsToSelector:@selector(vp_setInit)])
    {
        [self vp_setInit];
    }
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
