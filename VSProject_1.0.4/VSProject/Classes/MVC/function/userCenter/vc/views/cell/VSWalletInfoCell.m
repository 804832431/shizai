//
//  VSWalletInfoCell.m
//  VSProject
//
//  Created by tiezhang on 15/2/28.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSWalletInfoCell.h"

@interface VSWalletInfoCell ()

@property (strong, nonatomic) IBOutlet UIView *vm_line;


@end

@implementation VSWalletInfoCell

- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式
    
    [self.vm_line setBackgroundColor:kColor_d9d9d9];
    for (NSLayoutConstraint *contraint in self.vm_line.constraints)
    {
        if(contraint.firstAttribute == NSLayoutAttributeWidth)
        {
            contraint.constant = RETINA_1PX;
            break;
        }
    }
    [self.contentView layoutIfNeeded];
    
    [self.contentView setBackgroundColor:kColor_ffffff];
    [self vm_showBottonLine:YES];

}

+ (CGFloat)vp_height
{
    return 44.f;
}

- (void)vp_updateUIWithModel:(id)model
{
    //TODO：更新UI
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
