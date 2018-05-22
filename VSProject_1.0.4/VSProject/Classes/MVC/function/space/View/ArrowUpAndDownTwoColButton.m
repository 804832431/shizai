//
//  ArrowUpAndDownTwoColButton.m
//  VSProject
//
//  Created by pangchao on 2017/10/23.
//  Copyright © 2017年 user. All rights reserved.
//

#import "ArrowUpAndDownTwoColButton.h"

@implementation ArrowUpAndDownTwoColButton

- (void)setTitle:(nullable NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(__SCREEN_WIDTH__, MAXFLOAT)
                                           options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                           context:nil].size;
    float width = titleSize.width;
    
    if (width + 30 < __SCREEN_WIDTH__ / 2) {
        float imgHeadPosition = ((__SCREEN_WIDTH__/2 - width)/2 + width) + 10; //图片和文字留10像素间隔
        
        float imgTailPosition = __SCREEN_WIDTH__/2 - imgHeadPosition - 20;
        
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, imgHeadPosition, 0, imgTailPosition)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    } else {
        //字符过长
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, __SCREEN_WIDTH__/2 - 10, 0, -10)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    }
}

- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state {
    [super setTitleColor:color forState:state];
    if ([color isEqual:ColorWithHex(0x302f37, 1.0)]) {
        //箭头向下 xz_n
        [self setImage:__IMAGENAMED__(@"xz_n") forState:state];
    } else {
        //箭头向上 xz_2
        [self setImage:__IMAGENAMED__(@"xz_2") forState:state];
    }
}

@end
