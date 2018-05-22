//
//  ReundReasonBottomTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/8/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ReundReasonBottomTableViewCell.h"

@implementation ReundReasonBottomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = _Colorhex(0xf1f1f1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
