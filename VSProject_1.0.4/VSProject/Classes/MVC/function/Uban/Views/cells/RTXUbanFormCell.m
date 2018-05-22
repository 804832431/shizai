//
//  RTXUbanFormCell.m
//  VSProject
//
//  Created by XuLiang on 16/1/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXUbanFormCell.h"
@interface RTXUbanFormCell ()



@end

@implementation RTXUbanFormCell

- (void)vp_setInit{
    [super vp_setInit];
    //TODO：设置样式
    [self.contentView setBackgroundColor:kColor_ffffff];
    self.m_titleLbl.font = kSysFont_15;
    self.m_titleLbl.textAlignment = NSTextAlignmentJustified;
    self.m_contentTxt.textColor = kColor_999999;
    self.m_contentTxt.delegate = (id<UITextFieldDelegate>)self;
    [self.m_button setHidden:YES];
    
}

- (void)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_delegate textFieldDidBeginEditing:self];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [_delegate textFieldShouldBeginEditing:self];
    }else {
        return YES;
    }
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (_delegate && [_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
//        [_delegate textFieldDidBeginEditing:self];
//    }
//}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_delegate textFieldDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (_delegate && [_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [_delegate textField:self shouldChangeCharactersInRange:range replacementString:string];
    }else {
        return YES;
    }
}


+ (CGFloat)vp_cellHeightWithModel:(id)model withSuperWidth:(CGFloat)t_superWidth
{
    return 46.f;
}

- (void)vp_updateUIWithModel:(NSArray *)model{
    
    NSArray *modelArr = (NSArray *)model;

    self.m_titleLbl.text = [modelArr firstObject];
    self.m_contentTxt.text = [modelArr lastObject];;

}

@end
