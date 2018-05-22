//
//  VSInputBar.h
//  WYStarService
//
//  Created by BestBoy on 14/12/18.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSInputBar;
@protocol VSInputBarDelegate <NSObject>

@optional
- (void)vp_sendMessageClicked;
- (void)vp_startVoice;


- (void)vp_wyInputKeyBoardWasShown:(CGFloat)keyboardHeight;
- (void)vp_wyInputKeyBoardWWillBeHidden:(CGFloat)keyboardHeight;
- (void)vp_wyInputTextWasChanged;

@end


@interface VSInputBar : UIView
@property(nonatomic,weak)id<VSInputBarDelegate>delegate;
@property(nonatomic,strong)UITextView *inputTextView;
@property(nonatomic,strong)UIButton   *sendButton;
@property(nonatomic,strong)UIButton   *voxButton;

- (void)resetSendButtonEnabledNO;
- (void)resetSendButtonEnabledYES;
@end
