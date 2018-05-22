//
//  VSLeftIconTitleCell.m
//  VSProject
//
//  Created by user on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSLeftIconTitleCell.h"

@implementation VSIconTitleData

- (instancetype)initWithImageName:(NSString*)imageName titleText:(NSString*)title
{
    self = [super init];
    if(self)
    {
        self.vm_imageName = imageName;
        self.vm_titleText = title;
    }
    return self;
}

@end

@interface VSLeftIconTitleCell ()

_PROPERTY_NONATOMIC_STRONG(VSImageView, vm_leftIcon);

_PROPERTY_NONATOMIC_STRONG(VSLabel, vm_title);

@end

@implementation VSLeftIconTitleCell

- (void)vp_setInit
{
    //TODO：设置样式
    
    [self.contentView setBackgroundColor:kColor_ffffff];
    
    [self.contentView addSubview:self.vm_leftIcon];
    [self.vm_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@(15));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
        
    }];
    
    [self.contentView addSubview:self.vm_title];
    [self.vm_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.vm_leftIcon.mas_right).mas_offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(@(-30));
        make.height.equalTo(self.contentView.mas_height);
        
    }];
}

+ (CGFloat)vp_height
{
    return 44.f;
}

- (void)vp_updateUIWithModel:(VSIconTitleData*)model
{
    //TODO：更新UI
    
    self.vm_leftIcon.image = __IMAGENAMED__(model.vm_imageName);
    self.vm_title.text     = model.vm_titleText;
}

#pragma mark -- getter
_GETTER_ALLOC_BEGIN(VSImageView, vm_leftIcon)
{
}
_GETTER_END(vm_leftIcon)

_GETTER_ALLOC_BEGIN(VSLabel, vm_title)
{
    [_vm_title setFont:kSysFont_14];
    [_vm_title setTextColor:kColor_333333];
}
_GETTER_END(vm_title)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
