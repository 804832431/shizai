//
//  VSTestCell1.m
//  VSProject
//
//  Created by tiezhang on 15/1/15.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSTestCell1.h"

@implementation VSTestCell1

- (void)vp_setInit
{
    self.backgroundColor = [UIColor lightGrayColor];
    
}

+ (CGFloat)vp_height
{
    return 44.f;
}

- (void)vp_updateUIWithModel:(NSString*)model
{
    self.textLabel.text = model;
    self.textLabel.textColor = [UIColor blackColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
