//
//  VSImageView.m
//  VSProject
//
//  Created by user on 15/1/20.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSImageView.h"
#import "UIImageView+VSWebImage.h"
@implementation VSImageView

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    
    if([self respondsToSelector:@selector(vp_setInit)])
    {
        [self vp_setInit];
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    self = [super initWithImage:image highlightedImage:highlightedImage];
    
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
