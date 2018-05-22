//
//  VSAccountBottomCell.m
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSAccountBottomCell.h"

@interface VSAccountBottomCell ()

@property (weak, nonatomic) IBOutlet VSButton *vm_register;

@property (weak, nonatomic) IBOutlet VSButton *vm_forgot;

- (IBAction)vs_registerClicked:(id)sender;

- (IBAction)vs_forgotClicked:(id)sender;

@end

@implementation VSAccountBottomCell

- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式
    [self.vm_register setTitle:@"注册" forState:UIControlStateNormal];
    [self.vm_register setTitleColor:kColor_333333 forState:UIControlStateNormal];
    [self.vm_register.titleLabel setFont:kSysFont_13];
    [self.vm_register setBackgroundColor:[UIColor clearColor]];
//    [self.vm_register setBackgroundColor:kColor_ffffff];
    
    [self.vm_forgot setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.vm_forgot setTitleColor:kColor_333333 forState:UIControlStateNormal];
    [self.vm_forgot.titleLabel setFont:kSysFont_13];
    [self.vm_forgot setBackgroundColor:[UIColor clearColor]];
//    [self.vm_forgot setBackgroundColor:kColor_ffffff];
}

+ (CGFloat)vp_height
{
    return 44.f;
}

- (void)vp_updateUIWithModel:(id)model
{
    //TODO：更新UI
}


- (IBAction)vs_registerClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(vp_registerClicked:)])
    {
        [self.delegate vp_registerClicked:self];
    }
}

- (IBAction)vs_forgotClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(vp_forgotClicked:)])
    {
        [self.delegate vp_forgotClicked:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
