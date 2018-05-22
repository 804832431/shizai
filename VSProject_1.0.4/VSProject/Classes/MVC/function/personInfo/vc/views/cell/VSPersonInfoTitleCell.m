//
//  VSPersonInfoTitleCell.m
//  VSProject
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSPersonInfoTitleCell.h"
#import "VSPersonInfoItem.h"

@interface VSPersonInfoTitleCell ()


@end

@implementation VSPersonInfoTitleCell

- (void)vp_setInit
{
    _CLEAR_BACKGROUND_COLOR_(self.contentView);
    _CLEAR_BACKGROUND_COLOR_(self);
    
    [self.contentView addSubview:self.vm_titleLabel];
    [self.vm_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@(10));
        make.width.equalTo(@(75));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        
    }];
    
    [self.contentView addSubview:self.vm_valueLabel];
    [self.vm_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.vm_titleLabel.mas_right).mas_offset(3);
        make.right.equalTo(@(-10));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        
    }];
    
    [self vm_showBottonLine:YES];
}

+ (CGFloat)vp_height
{
    return 35.f;
}

- (void)vp_updateUIWithModel:(VSPersonInfoItem*)model
{
    self.vm_titleLabel.text = [NSString stringWithFormat:@"%@：", model.vm_title];
    
    self.vm_valueLabel.text = (model.vm_value.length <= 0) ? @"暂无" : model.vm_value;
}

#pragma mark -- getter
_GETTER_ALLOC_BEGIN(VSLabel, vm_titleLabel)
{
    [_vm_titleLabel setFont:kSysFont_14];
    [_vm_titleLabel setTextColor:kColor_333333];
}
_GETTER_END(vm_titleLabel)

_GETTER_ALLOC_BEGIN(VSLabel, vm_valueLabel)
{
    [_vm_valueLabel setFont:kSysFont_14];
    [_vm_valueLabel setTextColor:kColor_333333];
}
_GETTER_END(vm_valueLabel)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
