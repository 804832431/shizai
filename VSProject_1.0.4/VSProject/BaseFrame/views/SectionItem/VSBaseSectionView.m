//
//  WMBaseSetionView.m
//  beautify
//
//  Created by user on 15/1/4.
//  Copyright (c) 2015年 Elephant. All rights reserved.
//

#import "VSBaseSectionView.h"

@implementation VSBaseSectionView


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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
