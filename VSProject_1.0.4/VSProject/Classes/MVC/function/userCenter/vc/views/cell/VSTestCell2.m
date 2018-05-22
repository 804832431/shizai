//
//  VSTestCell2.m
//  VSProject
//
//  Created by tiezhang on 15/1/15.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSTestCell2.h"

@implementation VSTestCell2

+ (CGFloat)vp_cellHeightWithModel:(id)model withSuperWidth:(CGFloat)t_superWidth
{
    return 60.f;
}

- (void)vp_updateUIWithModel:(id)model
{
    self.textLabel.text         = model;
    self.textLabel.textColor    = [UIColor blackColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
