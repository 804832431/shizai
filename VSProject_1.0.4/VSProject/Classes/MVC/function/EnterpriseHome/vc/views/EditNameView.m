//
//  EditNameView.m
//  VSProject
//
//  Created by certus on 15/11/4.
//  Copyright © 2015年 user. All rights reserved.
//

#import "EditNameView.h"

@implementation EditNameView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)vp_setInit {
    
    [self.baseView addSubview:self.titleLabel];
    [_baseView addSubview:self.textField];
    [_baseView addSubview:self.cancelButton];
    [_baseView addSubview:self.sureButton];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_baseView.mas_left).with.offset(20);
        make.right.equalTo(_baseView.mas_right).with.offset(-20);
        make.top.equalTo(_baseView.mas_top).with.offset(23);
        make.height.equalTo(@20);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(20);
        make.width.equalTo(@206);
        make.centerX.equalTo(_baseView.mas_centerX);
        make.height.equalTo(@28);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_textField.mas_left);
        make.top.equalTo(_textField.mas_bottom).with.offset(10);
        make.right.equalTo(_baseView.mas_centerX).with.offset(-3);
        make.height.equalTo(@28);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_baseView.mas_centerX).with.offset(3);
        make.top.equalTo(_textField.mas_bottom).with.offset(10);
        make.right.equalTo(_textField.mas_right);
        make.height.equalTo(@28);
    }];

}
#pragma mark -- Action

- (void)actonCancelButton {

    [self hide];
}

- (void)actonSureButton {

    if (_delegate && [_delegate respondsToSelector:@selector(EditNameView:sureEditName:)]) {
        [_delegate EditNameView:self sureEditName:_textField.text];
    }
    [self hide];

}

#pragma mark -- public

- (void)show {
    
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5f];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4f;
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromLeft;
        [self addSubview:self.baseView];
        
        [self.layer addAnimation:transition forKey:@"changeHome"];
    });
    
}

- (void)hide {
    
    self.backgroundColor = [UIColor clearColor];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromLeft;
    [_baseView removeFromSuperview];
    [self.layer addAnimation:transition forKey:@"changeHome"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}

#pragma mark -- getter

_GETTER_ALLOC_BEGIN(UIView, baseView) {
    
    _baseView.frame = CGRectMake((MainWidth-721/3)/2, 0.26*MainHeight, 720/3, 460/3);
    _baseView.backgroundColor = [UIColor whiteColor];
    _baseView.layer.cornerRadius = 3.f;
    
}
_GETTER_END(baseView)

_GETTER_ALLOC_BEGIN(UITextField, textField)
{
    
    _textField.frame = CGRectMake((720-618)/6, MainWidth-100, 618/3, 84/3);
    _textField.backgroundColor = [UIColor clearColor];
    _textField.font = [UIFont systemFontOfSize:13];
    _textField.textColor = _COLOR_HEX(0x333333);
    _textField.delegate = (id<UITextFieldDelegate>)self;
    _textField.layer.cornerRadius = 3.f;
    _textField.layer.borderWidth = 1.f;
    _textField.layer.borderColor = _COLOR_HEX(0xdfdfdf).CGColor;

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35/3, 15)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.leftView = leftView;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;

}
_GETTER_END(textField)

_GETTER_ALLOC_BEGIN(UILabel, titleLabel)
{
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment =NSTextAlignmentCenter;
    _titleLabel.textColor = _COLOR_HEX(0x333333);
    _titleLabel.font = FONT_TITLE(13);
    _titleLabel.text = @"编辑昵称";
}
_GETTER_END(titleLabel)

_GETTER_ALLOC_BEGIN(UIButton, cancelButton)
{
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:_COLOR_HEX(0x333333) forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(actonCancelButton) forControlEvents:UIControlEventTouchUpInside];
    _cancelButton.titleLabel.font = FONT_TITLE(13);
    _cancelButton.layer.cornerRadius = 3.f;
    _cancelButton.layer.borderWidth = 1.f;
    _cancelButton.layer.borderColor = _COLOR_HEX(0xdfdfdf).CGColor;
    
}
_GETTER_END(cancelButton)


_GETTER_ALLOC_BEGIN(UIButton, sureButton)
{
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [_sureButton setTitleColor:_COLOR_HEX(0x35b38d) forState:UIControlStateNormal];
    [_sureButton addTarget:self action:@selector(actonSureButton) forControlEvents:UIControlEventTouchUpInside];
    _sureButton.titleLabel.font = FONT_TITLE(12);
    _sureButton.layer.cornerRadius = 3.f;
    _sureButton.layer.borderWidth = 1.f;
    _sureButton.layer.borderColor = _COLOR_HEX(0xdfdfdf).CGColor;
    
}
_GETTER_END(sureButton)

@end
