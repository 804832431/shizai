//
//  VSFindItemTableViewCell.m
//  VSProject
//
//  Created by tiezhang on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSFindItemTableViewCell.h"
#import "VSFindItemData.h"

@interface VSFindItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *vm_itemIcon;

@property (weak, nonatomic) IBOutlet UILabel *vm_itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *vm_itemDesc;

@end

@implementation VSFindItemTableViewCell

- (void)vp_setInit
{
    [self.contentView setBackgroundColor:kColor_ffffff];
    
    [self.vm_itemIcon setBackgroundColor:[UIColor redColor]];
    
    [self.vm_itemDesc setTextColor:kColor_808080];
}

+ (CGFloat)vp_height
{
    return 80.f;
}

- (void)vp_updateUIWithModel:(VSFindItemData*)model
{
    [self.vm_itemIcon setImage:__IMAGENAMED__(model.vm_iconName)];
    [self.vm_itemTitle setText:model.vm_title];
    [self.vm_itemDesc setText:model.vm_desc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
