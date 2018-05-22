//
//  VSPersonInfoTitleWithButton.m
//  VSProject
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSPersonInfoTitleWithButtonCell.h"
#import "VSPersonInfoItem.h"

@interface VSPersonInfoTitleWithButtonCell ()

_PROPERTY_NONATOMIC_STRONG(VSButton, vm_btnCheck);

@end

@implementation VSPersonInfoTitleWithButtonCell

- (void)vp_setInit
{
    [super vp_setInit];
    
    self.vm_valueLabel.hidden = YES;
    
    [self.contentView addSubview:self.vm_btnCheck];
    [self.vm_btnCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.vm_titleLabel.mas_right).mas_offset(3);
        make.width.equalTo(@(45));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        
    }];
}

- (void)vp_updateUIWithModel:(VSPersonInfoItem*)model
{
    [super vp_updateUIWithModel:model];
    
    if(model.vm_hasValue)
    {
        self.vm_valueLabel.hidden = !(model.vm_value.length > 0);
        
        self.vm_btnCheck.hidden = (model.vm_value.length > 0);
    }
    else
    {
        self.vm_valueLabel.hidden = NO;
        self.vm_btnCheck.hidden   = YES;
        self.vm_valueLabel.text   = @"暂无";
    }
}

- (void)checkClicked
{
    if([self.delegate respondsToSelector:@selector(personInfoCellCheckClicked:)])
    {
        [self.delegate personInfoCellCheckClicked:self];
    }
}

#pragma mark -- getter
_GETTER_BEGIN(VSButton, vm_btnCheck)
{
    _vm_btnCheck = [VSButton buttonWithType:UIButtonTypeCustom];
    [_vm_btnCheck setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_vm_btnCheck setTitle:@"查看" forState:UIControlStateNormal];
    [_vm_btnCheck.titleLabel setFont:kSysFont_14];
    [_vm_btnCheck addTarget:self action:@selector(checkClicked) forControlEvents:UIControlEventTouchUpInside];
    
}
_GETTER_END(vm_btnCheck)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
