//
//  RTXBottomBtnActionCell.m
//  VSProject
//
//  Created by XuLiang on 15/11/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "RTXBottomBtnActionCell.h"

@interface RTXBottomBtnActionCell ()

@property (weak, nonatomic) IBOutlet UIButton *vm_btnAction;

- (IBAction)vs_btnClicked:(id)sender;

@end

@implementation RTXBottomBtnActionCell


- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式
    
//    _SETDEFAULT_VIEW_STYLE_(self.vm_btnAction, kColor_Clear, 4);
    
//    [self.vm_btnAction setBackgroundColor:_RGB_A(253.f, 142.0f, 20.f, 1.f)];
    [self.vm_btnAction setBackgroundImage:[[UIImage imageNamed:@"bg_nav_green"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateNormal];
    [self.vm_btnAction setBackgroundImage:[[UIImage imageNamed:@"grayimg"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateDisabled];
    [self.vm_btnAction setTitleColor:kColor_ffffff forState:UIControlStateNormal];
    [self.vm_btnAction.titleLabel setFont:kSysFont_15];
}

+ (CGFloat)vp_height
{
    return 50.f;
}

- (IBAction)vs_btnClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(vp_btnActionClicked:)])
    {
        [self.delegate vp_btnActionClicked:self];
    }
}

- (void)vp_updateUIWithModel:(id)model
{
    //TODO：更新UI
    [self.vm_btnAction setTitle:model forState:UIControlStateNormal];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
