//
//  ForgetAccountInfoCell.m
//  VSProject
//
//  Created by XuLiang on 15/10/29.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ForgetAccountInfoCell.h"
#import "LoginAccountModel.h"
@interface ForgetAccountInfoCell ()
@end

@implementation ForgetAccountInfoCell
//设置ui样式
- (void)vp_setInit{
    [super vp_setInit];
    //TODO：设置样式
    [self.contentView setBackgroundColor:kColor_Clear];
    
    self.vm_txtInfo.font = kSysFont_13;
    self.vm_txtInfo.textColor = kColor_333333;
    self.vm_txtInfo.delegate = (id<UITextFieldDelegate>)self;
    self.vm_txtInfo.keyboardType = UIKeyboardTypeNumberPad;
    [self vm_showBottonLine:YES];
}

- (void)textFieldDidEndEditing:(ForgetAccountInfoCell *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(infotextFieldDidEndEditing:)]) {
        [_delegate infotextFieldDidEndEditing:self];
    }
}

//返回UI高度
+ (CGFloat)vp_height{
    return 63;
}
//根据数据模型更新ui
- (void)vp_updateUIWithModel:(id)model{
    if ([model isKindOfClass:[LoginAccountModel class]]) {
        LoginAccountModel *m_model = (LoginAccountModel *)model;
        
        self.vm_txtInfo.placeholder = m_model.m_placeholder;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 15)];
        UIImageView *headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(7, 0, 13, 15)];
        [headIcon setImage:[UIImage imageNamed:m_model.m_iconName]];
        [leftView addSubview:headIcon];
        self.vm_txtInfo.leftViewMode = UITextFieldViewModeAlways;
        self.vm_txtInfo.leftView = leftView;
    }else{
        self.vm_txtInfo.placeholder = (NSString *)model;
    }
}

- (NSString*)vs_infoText
{
    return self.vm_txtInfo.text;
}

@end
