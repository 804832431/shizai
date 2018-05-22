//
//  VSPersonInfoSpaceCell.m
//  VSProject
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSPersonInfoSpaceCell.h"

@implementation VSPersonInfoSpaceCell

- (void)vp_setInit
{
    [super vp_setInit];
    
    [self vm_showBottonLine:YES];
}

+ (CGFloat)vp_height
{
    return 18.f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
