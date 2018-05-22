//
//  ForgetAccountbtnCelll.m
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "ForgetAccountbtnCell.h"
#import "LoginAccountModel.h"

@interface ForgetAccountbtnCell ()

//@property (weak, nonatomic) IBOutlet VSTextField *vm_txtInfo;
//@property (weak, nonatomic) IBOutlet UIButton *vm_getcodeBtn;
//

@property (strong, nonatomic) UIImageView *leftIconImageView;

@end


@implementation ForgetAccountbtnCell

- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    
    self.vm_txtInfo.font = kSysFont_13;
    self.vm_txtInfo.textColor = kColor_333333;
    self.vm_txtInfo.delegate = (id<UITextFieldDelegate>)self;
    self.vm_txtInfo.keyboardType = UIKeyboardTypeNumberPad;
    [self vm_showBottonLine:NO];
    
//    [self.vm_getcodeBtn setBackgroundColor:ColorWithHex(0x7dc67f,1)];
//    [self.vm_getcodeBtn setBackgroundImage:[UIImage imageNamed:@"login_15"] forState:UIControlStateNormal];
    [self.vm_getcodeBtn setTitleColor:kColor_333333 forState:UIControlStateNormal];
    [self.vm_getcodeBtn.titleLabel setFont:kSysFont_12];
    [self.vm_getcodeBtn addTarget:self action:@selector(actionSendCaptcha) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFieldDidEndEditing:(ForgetAccountbtnCell *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_delegate textFieldDidEndEditing:self];
    }
}

- (void)textFieldDidBeginEditing:(ForgetAccountbtnCell *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_delegate textFieldDidBeginEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (_delegate && [_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [_delegate textField:self shouldChangeCharactersInRange:range replacementString:string];
    }else {
        return YES;
    }
}

- (void)actionSendCaptcha {
    if (_delegate && [_delegate respondsToSelector:@selector(actionSendCaptcha:)]) {
        [_delegate actionSendCaptcha:self];
    }

}

+ (CGFloat)vp_height
{
    return 70.f;
}

- (void)vp_updateUIWithModel:(id)model
{
//    //TODO：更新UI
//    if ([model isKindOfClass:[LoginAccountModel class]]) {
//        LoginAccountModel *m_model = (LoginAccountModel *)model;
//        
//        if (m_model.m_title) {
//            //修改密码带用户的注册手机号
//            self.vm_txtInfo.text = m_model.m_title;
//            self.vm_txtInfo.userInteractionEnabled = NO;
//        }
//        self.vm_txtInfo.placeholder = m_model.m_placeholder;
//        
//        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 15)];
//        UIImageView *headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(7, 0, 13, 15)];
//        [headIcon setImage:[UIImage imageNamed:m_model.m_iconName]];
//        [leftView addSubview:headIcon];
//        self.vm_txtInfo.leftViewMode = UITextFieldViewModeAlways;
//        self.vm_txtInfo.leftView = leftView;
//        
//        [self.vm_getcodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    }else{
//        self.vm_txtInfo.placeholder = (NSString *)model;
//    }
    
    //TODO：更新UI
    if ([model isKindOfClass:[LoginAccountModel class]]) {
        LoginAccountModel *m_model = (LoginAccountModel *)model;
        
        //        self.vm_txtInfo.placeholder = m_model.m_placeholder;
        NSString *holderText = m_model.m_placeholder;
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:_COLOR_HEX(0x999999)
                            range:NSMakeRange(0, holderText.length)];
        [placeholder addAttribute:NSFontAttributeName
                            value:[UIFont boldSystemFontOfSize:15]
                            range:NSMakeRange(0, holderText.length)];
        self.vm_txtInfo.attributedPlaceholder = placeholder;
        
        [self.vm_txtInfo setFrame:CGRectMake(64, 30, __SCREEN_WIDTH__ - 64 - 33 - 127, 30)];
        
        [self.vm_txtInfo setTextAlignment:NSTextAlignmentLeft];
        
        if ([self.vm_txtInfo.placeholder isEqualToString:@"请输入手机号"]) {
            self.vm_txtInfo.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (m_model.m_security) {
            self.vm_txtInfo.secureTextEntry = YES;
        }
        
        //modify by Thomas ［UI切图尺寸随机，为保证图片不被拉伸，获取图片尺寸后布局］---start
        //        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:m_model.m_iconName]];
        //        CGFloat imageWidth = CGRectGetWidth(image.frame);
        //        CGFloat imageHeight = CGRectGetHeight(image.frame);
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(33, 30, 34, 15)];
        if (!_leftIconImageView) {
            _leftIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7.0f, 5.5f, 13.5f, 19.0f)];
        }
        //modify by Thomas ［UI切图尺寸随机，为保证图片不被拉伸，获取图片尺寸后布局］---end
        [_leftIconImageView setImage:[UIImage imageNamed:m_model.m_iconName]];
//        self.leftIconImageView = headIcon;
        [leftView addSubview:_leftIconImageView];
        self.vm_txtInfo.leftView.frame = CGRectMake(0, 0, 0, 0);
        self.vm_txtInfo.leftViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:leftView];
        
        [self.vm_getcodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else{
        self.vm_txtInfo.placeholder = (NSString *)model;
    }
    [self setNeedsDisplay];
}

- (NSString*)vs_infoText
{
    return self.vm_txtInfo.text;
}

- (void)updateLeftImage:(NSString *)imageName {
    
    self.leftIconImageView.image = [UIImage imageNamed:imageName];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
