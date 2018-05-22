//
//  VSSectionTitleView.m
//  VSProject
//
//  Created by user on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSSectionTitleView.h"

@interface VSSectionTitleView ()

@end

@implementation VSSectionTitleView

- (void)vp_setInit
{
    [self setBackgroundColor:kColor_d9d9d9];
    [self addSubview:self.vm_titleLabel];
    [self.vm_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(10));
        make.right.equalTo(@(-10));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        
    }];
}

+ (CGFloat)vp_height
{
    return 28.f;
}

- (void)vp_updateUIWithModel:(NSString*)model
{
    self.vm_titleLabel.text = model;
}

#pragma mark -- getter
_GETTER_ALLOC_BEGIN(VSLabel, vm_titleLabel)
{
    [_vm_titleLabel setTextColor:kColor_808080];
    [_vm_titleLabel setFont:kBoldFont_14];
}
_GETTER_END(vm_titleLabel)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
