//
//  VSPersionHeadInfoCell.m
//  VSProject
//
//  Created by user on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSPersonHeadInfoCell.h"
#import "VSPersonInfoManager.h"
#import "VSMemberDataInfo.h"

@interface VSPersonHeadInfoCell ()

@property (weak, nonatomic) IBOutlet VSImageView *vm_headAvar;
@property (weak, nonatomic) IBOutlet VSLabel *vm_name;
@property (weak, nonatomic) IBOutlet VSLabel *vm_age;
@property (weak, nonatomic) IBOutlet VSImageView *vm_sexIcon;
@property (weak, nonatomic) IBOutlet VSImageView *vm_picsEnter;

@property (strong, nonatomic)VSImageView *vm_vipIcon;

@end

@implementation VSPersonHeadInfoCell

- (void)vp_setInit
{
    //TODO:初始化样式
    
    [super vp_setInit];
    
    [self.contentView setBackgroundColor:kColor_ffffff];
    
    [self.vm_name setFont:kSysFont_14];
    [self.vm_name setTextColor:kColor_666666];

    [self.vm_age setFont:kSysFont_12];
    
    [self.vm_picsEnter setBackgroundColor:kColor_cccccc];
    
    [self vm_showBottonLine:YES];
}

+ (CGFloat)vp_height
{
    return 100.f;
}

- (void)vp_updateUIWithModel:(VSMemberDataInfo*)model
{
    //TODO:更新UI
    
    UIColor *t_sexColor = (model.vm_sexType == SEX_TYPE_FEMALE) ? kColor_FeMale :  kColor_Male;
    [self.vm_age setTextColor:t_sexColor];
    [self.vm_sexIcon setBackgroundColor:t_sexColor];
    [self.vm_age setText:@"21"];
    //[self.vm_age setText:model.vm_age];
    
    self.vm_name.text = @"晓航";//model.vm_userNickName
    [self.vm_headAvar sd_setImageWithString:model.vm_headAvar placeholderImage:kPlaceHolderImage];
    
    VIP_TYPE vipType = VIP_TYPE_NO1;//model.vm_vipType
    if(vipType != VIP_TYPE_NONE)
    {
        [self.contentView addSubview:self.vm_vipIcon];
        [self.vm_vipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.equalTo(@(15));
            make.height.equalTo(@(15));
            make.centerX.equalTo(self.vm_headAvar.mas_left);
            make.centerY.equalTo(self.vm_headAvar.mas_top);
            
        }];
    }
    else
    {
        [_vm_vipIcon removeFromSuperview];
        _vm_vipIcon = nil;
    }

}

#pragma mark -- getter
_GETTER_ALLOC_BEGIN(VSImageView, vm_vipIcon)
{
    
}
_GETTER_END(vm_vipIcon)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
