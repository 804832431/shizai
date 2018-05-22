//
//  VSChatLongPressLabel.m
//  WYStarService
//
//  Created by BestBoy on 14/12/29.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import "VSChatLongPressLabel.h"



@implementation VSChatLongPressLabel

- (id)init
{
    if (self = [super init]) {
        _isSendSuccess = YES;
        
        [self addLongPress];
    }
    return self;
}

- (void)longPress:(UIGestureRecognizer*)gest
{
    
    [self becomeFirstResponder];
    UIMenuItem *reSend = [[UIMenuItem alloc] initWithTitle:@"重新发送" action:@selector(reSendMsg:)];
//    UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMsg:)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:reSend, nil]];
    [menu setTargetRect:self.frame inView:[self superview]];
    [menu setMenuVisible:YES animated:YES];
    [menu update];
}

- (void)reSendMsg:(id)sender
{
//    [KNotificationCenter postNotificationName:NoticeName_ReSendMsg object:self.chatModell];
    if([self.delegate respondsToSelector:@selector(vp_resendMsg:)])
    {
        [self.delegate vp_resendMsg:self];
    }
}

//- (void)deleteMsg:(id)sender
//{
//    [KNotificationCenter postNotificationName:NoticeName_DeleteMsg object:self.chatModell];
//}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
//    if (action == @selector(reSendMsg:)||action == @selector(deleteMsg:))
    if (action == @selector(reSendMsg:))
    {
        return YES;
    }
    return NO;
}

- (void)setIsSendSuccess:(BOOL)isSendSuccess
{
    _isSendSuccess = isSendSuccess;
    if (!_isSendSuccess)
    {
        [self addLongPress];
    }
}

- (void)addLongPress
{
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    press.minimumPressDuration = 0.8;
    
    [self addGestureRecognizer:press];
}

@end
