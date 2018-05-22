//
//  VSPlaceHolderTextView.m
//  VSProject
//
//  Created by user on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSPlaceHolderTextView.h"

#define kColor_placeHolder      kColor_d9d9d9

#define kColor_normal           kColor_333333

@interface VSPlaceHolderTextView ()

@end

@implementation VSPlaceHolderTextView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
}

- (void)vp_setInit
{
    self.vm_placeHolderColor = kColor_placeHolder;
    self.text                = self.vm_placeHolderString;
    self.textColor           = self.vm_placeHolderColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(txtBeginEdit:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(txtDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(txtEndEdit:) name:UITextViewTextDidEndEditingNotification object:nil];
}

#pragma mark -- UITextViewDelegate
- (void)txtBeginEdit:(NSNotification*)notification
{
    if(self.text.length > 0 &&
       ![self.text isEqualToString:self.vm_placeHolderString])
    {
        self.textColor = kColor_normal;
    }
    else if(self.text.length == 0)
    {
        self.textColor = kColor_normal;
    }
    else
    {
        self.text = @"";
        self.textColor = kColor_normal;
    }
}

- (void)txtDidChanged:(NSNotification*)notification
{
    
}

- (void)txtEndEdit:(NSNotification*)notification
{
    if(self.text.length == 0)
    {
        [self setTextColor:self.vm_placeHolderColor];
        [self setText:self.vm_placeHolderString];
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
