//
//  WMBaseTableViewCell.m
//  beautify
//
//  Created by user on 14/11/20.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@interface VSBaseTableViewCell ()

_PROPERTY_NONATOMIC_STRONG(UIView, wm_defaultBottomLine);

@end

@implementation VSBaseTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    if([self respondsToSelector:@selector(vp_setInit)])
    {
        [self vp_setInit];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        if([self respondsToSelector:@selector(vp_setInit)])
        {
            [self vp_setInit];
        }
    }
    return self;
}

- (void)vm_showBottonLine:(BOOL)show
{
    return [self vm_showBottonLine:show lineColor:kColor_d9d9d9];
}

- (void)vm_showBottonLine:(BOOL)show lineColor:(UIColor *)lineColor
{
    if(show)
    {
        [self.contentView addSubview:self.wm_defaultBottomLine];
        
        [self.wm_defaultBottomLine setBackgroundColor:lineColor];
    }
    else
    {
        [_wm_defaultBottomLine removeFromSuperview];
    }
}

- (void)vp_setInit
{
    _CLEAR_BACKGROUND_COLOR_(self.contentView);
    _CLEAR_BACKGROUND_COLOR_(self);
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

//+ (CGFloat)wy_cellHeight
//{
//    NSAssert(0, @"子类需实现此method(wy_cellHeight)");
//    
//    return 0;
//}
//
//+ (CGFloat)vp_cellHeightWithModel:(id)model
//{
//    NSAssert(0, @"子类需实现此method(vp_cellHeightWithModel:(id)model)");
//    
//    return 0;
//}

#pragma mark -- getter
_GETTER_ALLOC_BEGIN(UIView, wm_defaultBottomLine)
{
    _CLEAR_BACKGROUND_COLOR_(_wm_defaultBottomLine);
    [self.contentView addSubview:_wm_defaultBottomLine];
    [_wm_defaultBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(RETINA_1PX));
        
    }];
}
_GETTER_END(wm_defaultBottomLine)

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
