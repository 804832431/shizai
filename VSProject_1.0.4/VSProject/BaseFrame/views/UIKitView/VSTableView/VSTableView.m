//
//  VSTableView.m
//  VSProject
//
//  Created by user on 15/1/20.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSTableView.h"

@implementation VSTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if([self respondsToSelector:@selector(vp_setInit)])
    {
        [self vp_setInit];
    }

    return self;
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
