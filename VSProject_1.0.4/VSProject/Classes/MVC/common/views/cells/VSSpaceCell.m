//
//  VSPersonInfoSpaceCell.m
//  VSProject
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSSpaceCell.h"

@implementation VSSpaceCell

- (void)vp_setInit
{
    [super vp_setInit];
    
    [self vm_showBottonLine:NO];
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
