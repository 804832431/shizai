//
//  VSZixunSquareListCell.m
//  VSProject
//
//  Created by tiezhang on 15/4/12.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSZixunSquareListCell.h"

@interface VSZixunSquareListCell ()

@property (weak, nonatomic) IBOutlet VSImageView *vm_imageView;

@property (weak, nonatomic) IBOutlet VSLabel *vm_titleLabel;
@property (weak, nonatomic) IBOutlet VSView *vm_infoContentView;

@property (strong, nonatomic) VSLabel *vm_newsContent;

@end

@implementation VSZixunSquareListCell

- (void)vp_setInit
{
    _CLEAR_BACKGROUND_COLOR_(self.contentView);
    _CLEAR_BACKGROUND_COLOR_(self);
    //TODO：设置样式
    
    _CLEAR_BACKGROUND_COLOR_(self.vm_imageView);
    _CLEAR_BACKGROUND_COLOR_(self.vm_titleLabel);
    
    
    _CLEAR_BACKGROUND_COLOR_(self.vm_infoContentView);
    
    [self.vm_infoContentView addSubview:self.vm_newsContent];
    [self.vm_newsContent mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.vm_infoContentView);
        
    }];
}

+ (CGFloat)vp_height
{
    return 100.f;
}

- (void)vp_updateCellInfoWithModel:(id)model withSuperWidth:(CGFloat)t_superWidth
{
    //TODO：更新UI

    [self.vm_imageView sd_setImageWithString:@"http://i2.sinaimg.cn/edu/idx/2015/0417/U12218P42T315D1F10812DT20150417185813.jpg" placeholderImage:nil];
    
    self.vm_titleLabel.text = @"22岁女孩被6所美国名校录取 特点是贪玩";

    
    NSString *contentStr = @"近日来，商洛市22岁女孩唐巩被美国麻省理工学院录取并获得全额奖学金一事，成为商洛人热议的话题。谈及";
    CGFloat textHeight = MIN(ceilf([NSString caculateTextSize:contentStr width:(t_superWidth - 100) fontSize:12].height), 45);
    [self.vm_newsContent mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(@(0));
        make.height.equalTo(@(textHeight));
        
    }];
    self.vm_newsContent.text = contentStr;
    
}

#pragma mark -- getter
_GETTER_ALLOC_BEGIN(VSLabel, vm_newsContent)
{
    _CLEAR_BACKGROUND_COLOR_(_vm_newsContent);
    [_vm_newsContent setTextColor:kColor_333333];
    [_vm_newsContent setFont:kSysFont_12];
    [_vm_newsContent setLineBreakMode:NSLineBreakByTruncatingTail];
    _vm_newsContent.numberOfLines = 0;
    [_vm_newsContent sizeToFit];
}
_GETTER_END(vm_newsContent)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
