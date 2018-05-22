//
//  VSPersonInfoSectionTitleView.m
//  VSProject
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSPersonInfoSectionTitleView.h"

@interface VSPersonInfoSectionTitleView ()



@end

@implementation VSPersonInfoSectionTitleView

- (void)vp_setInit
{
    [super vp_setInit];
}

- (void)vp_updateUIWithModel:(NSString*)model
{
    self.vm_titleLabel.text = model;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
