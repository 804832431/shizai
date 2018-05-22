//
//  ForgetAccountBottomCell.m
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "ForgetAccountBottomCell.h"

@interface ForgetAccountBottomCell ()

@property (weak, nonatomic) IBOutlet VSButton *vm_login;


- (IBAction)vs_loginClicked:(id)sender;


@end

@implementation ForgetAccountBottomCell

- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式
    [self.vm_login setTitle:@"账号登录" forState:UIControlStateNormal];
    [self.vm_login setTitleColor:kColor_24bdef forState:UIControlStateNormal];
    [self.vm_login.titleLabel setFont:kSysFont_13];
    
    [self.vm_login setHidden:YES];
}

+ (CGFloat)vp_height
{
    return 44.f;
}

- (void)vp_updateUIWithModel:(id)model
{
    //TODO：更新UI
}


- (IBAction)vs_loginClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(vp_loginClicked:)])
    {
        [self.delegate vp_loginClicked:self];
    }
}

@end
