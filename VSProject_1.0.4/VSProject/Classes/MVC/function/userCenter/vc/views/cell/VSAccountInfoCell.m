//
//  VSLoginInfoCell.m
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSAccountInfoCell.h"
#import "LoginAccountModel.h"
#import "PassWordModel.h"

@interface VSAccountInfoCell ()

//@property (weak, nonatomic) IBOutlet VSTextField *vm_txtInfo;
@property (weak, nonatomic) IBOutlet UIImageView *m_lineview;

@property (nonatomic, strong) UIImageView *leftIconImageView;

@end


@implementation VSAccountInfoCell

- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    //距前有像素的分割线
    self.m_lineview.backgroundColor = _COLOR_HEX(0x1b1b1b);
    
    self.vm_txtInfo.font = kBoldFont_18;
    self.vm_txtInfo.textColor = _COLOR_HEX(0x212121);
    self.vm_txtInfo.delegate = (id<UITextFieldDelegate>)self;
    self.vm_txtInfo.keyboardType = UIKeyboardTypeAlphabet;
    self.vm_txtInfo.textAlignment = NSTextAlignmentCenter;
    self.vm_txtInfo.tintColor = kColor_999999;
    [self.vm_txtInfo setValue:kSysFont_12 forKeyPath:@"_placeholderLabel.font"];
    [self vm_showBottonLine:NO];
}

+ (CGFloat)vp_height
{
    return 70.f;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (_delegate && [_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_delegate textFieldDidEndEditing:self];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)sender {
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

- (void)vp_updateUIWithModel:(id)model
{
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
        
        [self.vm_txtInfo setTextAlignment:NSTextAlignmentLeft];
        
        if ([self.vm_txtInfo.placeholder isEqualToString:@"请输入手机号"]) {
            self.vm_txtInfo.keyboardType = UIKeyboardTypeNumberPad;
        }
        if ([self.vm_txtInfo.placeholder isEqualToString:@"请输入11位手机号"]) {
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
        UIImageView *headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(7.0f, 5.5f, 13.5f, 19.0f)];
        //modify by Thomas ［UI切图尺寸随机，为保证图片不被拉伸，获取图片尺寸后布局］---end
        [headIcon setImage:[UIImage imageNamed:m_model.m_iconName]];
        self.leftIconImageView = headIcon;
        [leftView addSubview:headIcon];
        self.vm_txtInfo.leftView.frame = CGRectMake(0, 0, 0, 0);
        self.vm_txtInfo.leftViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:leftView];
    }else if ([model isKindOfClass:[PassWordModel class]]) {
        PassWordModel *m_model = (PassWordModel *)model;
        
        self.vm_txtInfo.placeholder = m_model.m_placeholder;
        if (m_model.m_security) {
            self.vm_txtInfo.secureTextEntry = YES;
        }
    }else{
        self.vm_txtInfo.placeholder = (NSString *)model;
    }
    [self.vm_txtInfo setFrame:CGRectMake(64, 30, __SCREEN_WIDTH__ - 64 - 33, 30)];
    
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
