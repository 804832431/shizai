//
//  VSInputBar.m
//  WYStarService
//
//  Created by BestBoy on 14/12/18.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import "VSInputBar.h"

#define UIColor_Clear         [UIColor clearColor]
#define UIColor_Red           [UIColor redColor]
#define UIColor_Green         [UIColor greenColor]
#define UIColor_Blue          [UIColor blueColor]
#define UIColor_Gray          [UIColor grayColor]
#define UIColor_Black         [UIColor blackColor]
#define UIColor_DarkGray      [UIColor darkGrayColor]
#define UIColor_LightGray     [UIColor lightGrayColor]
#define UIColor_White         [UIColor whiteColor]
#define UIColor_Cyan          [UIColor cyanColor]
#define UIColor_Yellow        [UIColor yellowColor]
#define UIColor_Magenta       [UIColor  magentaColor]
#define UIColor_Orange        [UIColor orangeColor]
#define UIColor_Purple        [UIColor purpleColor]
#define UIColor_Brown         [UIColor brownColor]
#define UIColor_RGB(r, g, b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]



#define buttonWidth        55
#define InputViewHeight    45


@implementation VSInputBar

- (void)dealloc
{
    [KNotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [KNotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [KNotificationCenter removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}



-(id)init
{
    if (self= [super init]) {
        self.backgroundColor = _COLOR_HEX(0x3584dd);
        
        
        _inputTextView = [[UITextView alloc] init];
        _inputTextView.backgroundColor = UIColor_White;
        _inputTextView.font = FONT_TITLE(15);
        _inputTextView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_inputTextView];
        [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@3);
            make.bottom.equalTo(@(-3));
            make.left.equalTo(@5);
            make.right.equalTo(@(-buttonWidth*1-10));
        }];
        
        
//        _voxButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _voxButton.enabled = YES;
//        [_voxButton setTitle:@"语音" forState:UIControlStateNormal];
//        [_voxButton setTitleColor:UIColor_White forState:UIControlStateNormal];
//        [_voxButton setTitleColor:UIColor_Orange forState:UIControlStateHighlighted];
//        [_voxButton addTarget:self action:@selector(yuyinstart:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_voxButton];
//        [_voxButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@3);
//            make.bottom.equalTo(@(-3));
//            make.left.equalTo(_inputTextView.mas_right).offset(5);
//            make.width.equalTo(@(buttonWidth));
//        }];
        
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.enabled = NO;
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:UIColor_White forState:UIControlStateNormal];
        [_sendButton setTitleColor:UIColor_Orange forState:UIControlStateHighlighted];
        [_sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendButton];
        [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@3);
            make.bottom.equalTo(@(-3));
//            make.left.equalTo(_voxButton.mas_right).offset(0);
            make.left.equalTo(_inputTextView.mas_right).offset(0);
            make.width.equalTo(@(buttonWidth));
        }];
        
        [KNotificationCenter addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
        [KNotificationCenter addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
        [KNotificationCenter addObserver:self selector:@selector(textViewTextHaveChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}


//- (void)transformVoiceToTextMessage:(UIButton*)sender
//{
//    
//}

- (void)sendMessage:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(vp_sendMessageClicked)]) {
        [_delegate vp_sendMessageClicked];
    }
}
- (void)yuyinstart:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(vp_startVoice)]) {
        [_delegate vp_startVoice];
    }
}

- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary  *dic = [notification userInfo];
    CGSize keyboardSize = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat keyheight = keyboardSize.height;
    NSTimeInterval timerNum = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:timerNum animations:^{
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(0));
            make.left.equalTo(@0);
            make.bottom.equalTo(@(-keyheight));
            make.height.equalTo(@(InputViewHeight));
        }];
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(vp_wyInputKeyBoardWasShown:)]) {
            [_delegate vp_wyInputKeyBoardWasShown:keyheight];
        }
    }];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    NSDictionary  *dic = [notification userInfo];
    CGSize keyboardSize = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat keyheight = keyboardSize.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(0));
            make.left.equalTo(@0);
            make.bottom.equalTo(@(0));
            make.height.equalTo(@(InputViewHeight));
        }];
    } completion:^(BOOL finished) {
        [_inputTextView resignFirstResponder];
        if ([_delegate respondsToSelector:@selector(vp_wyInputKeyBoardWWillBeHidden:)]) {
            [_delegate vp_wyInputKeyBoardWWillBeHidden:keyheight];
        }
    }];
    
    
}


- (void)textViewTextHaveChanged:(NSNotification*)notification
{
    if (_inputTextView.text.length != 0) {
        [self resetSendButtonEnabledYES];
    }else{
        [self resetSendButtonEnabledNO];
    }
}


- (void)resetSendButtonEnabledYES
{
    [_sendButton setTitleColor:UIColor_Blue forState:UIControlStateNormal];
    _sendButton.enabled = YES;
}

- (void)resetSendButtonEnabledNO
{
    _inputTextView.text = @"";
    [_sendButton setTitleColor:UIColor_White forState:UIControlStateNormal];
    _sendButton.enabled = NO;
}


@end
