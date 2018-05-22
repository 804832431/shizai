//
//  VSAccountBtnActionCell.m
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSAccountBtnActionCell.h"

@interface VSAccountBtnActionCell ()

@property (weak, nonatomic) IBOutlet UIButton *vm_btnAction;

- (IBAction)vs_btnClicked:(id)sender;

@end

@implementation VSAccountBtnActionCell


- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式
    
    _SETDEFAULT_VIEW_STYLE_(self.vm_btnAction, kColor_Clear, 4);
    
//    [self.vm_btnAction setBackgroundColor:_RGB_A(253.f, 142.0f, 20.f, 1.f)];
    [self.vm_btnAction setBackgroundImage:[self createImageWithColor:_Colorhex(0x8aebcc)] forState:UIControlStateNormal];
    [self.vm_btnAction setBackgroundImage:[self createImageWithColor:_Colorhex(0x3cdeaa)] forState:UIControlStateHighlighted];
    [self.vm_btnAction setTitleColor:_COLOR_HEX(0x333333) forState:UIControlStateNormal];
    [self.vm_btnAction setTitleColor:_COLOR_HEX(0x333333) forState:UIControlStateDisabled];
    [self.vm_btnAction.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    self.vm_btnAction.layer.masksToBounds = YES;
//    self.vm_btnAction.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
    self.vm_btnAction.layer.borderWidth = 0.0f;
    self.vm_btnAction.layer.cornerRadius = 4.0f;
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, MainWidth, 64.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextClearRect(context, rect);
    
    return myImage;
}


+ (CGFloat)vp_height
{
    return 150.f;
}

- (IBAction)vs_btnClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(vp_btnActionClicked:)])
    {
        [self.delegate vp_btnActionClicked:self];
    }
}
- (void)btnEnabled:(BOOL)m_bool{
    self.vm_btnAction.enabled = m_bool;
    if (m_bool) {
        self.vm_btnAction.layer.borderColor = _COLOR_HEX(0x09aa89).CGColor;
    }
    else {
        self.vm_btnAction.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
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
