//
//  PicPlaceholerView.m
//  VSProject
//
//  Created by YaoJun on 15/10/28.
//  Copyright © 2015年 user. All rights reserved.
//

#import "PicPlaceholerView.h"

@implementation PicPlaceholerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)vp_setInit {

    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.leftImageView];
    [self addSubview:self.textField];
    //[self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(17.0f);
        make.top.equalTo(self.mas_top).with.offset(20.0f);
        make.width.equalTo(@14);
        make.height.equalTo(@19);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(75);
        make.top.equalTo(self.mas_top).with.offset(20.0f);
        make.right.equalTo(self.mas_right).with.offset(-75);
        make.height.equalTo(@19);
    }];
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@0.5);
    }];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@0.5);
    }];

}

- (void)vp_updateUIWithModel:(id)model {

    if ([model isKindOfClass:[NSNumber class]]) {
        NSNumber *amodel = (NSNumber *)model;
        
        [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).with.offset(40/3);
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right).with.offset(amodel.floatValue);
            make.height.equalTo(@50);
        }];

    }else if ([model isKindOfClass:[NSDictionary class]]) {
        NSDictionary *amodel = (NSDictionary *)model;
        NSNumber *top = [amodel objectForKey:@"top"];
        NSNumber *bottom = [amodel objectForKey:@"bottom"];

        [_topLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(top);
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@0.5);
        }];
        [_bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottom);
            make.top.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@0.5);
        }];
    }
}
#pragma mark -- getter

_GETTER_ALLOC_BEGIN(UIImageView, leftImageView)
{

    _leftImageView.backgroundColor = [UIColor clearColor];
}
_GETTER_END(leftImageView)

_GETTER_ALLOC_BEGIN(UITextField, textField)
{
    _textField.backgroundColor = [UIColor clearColor];
    _textField.font = [UIFont systemFontOfSize:18];
    _textField.textColor = _COLOR_HEX(0x212121);
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.delegate = (id<UITextFieldDelegate>)self;
    _textField.tintColor = _COLOR_HEX(0x212121);
}
_GETTER_END(textField)

_GETTER_ALLOC_BEGIN(UILabel, topLine)
{
    _topLine.backgroundColor = _COLOR_HEX(0xdbdbdb);
}
_GETTER_END(topLine)

_GETTER_ALLOC_BEGIN(UILabel, bottomLine)
{
    _bottomLine.backgroundColor = _COLOR_HEX(0x1b1b1b);
}
_GETTER_END(bottomLine)

#pragma mark --UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}

@end
