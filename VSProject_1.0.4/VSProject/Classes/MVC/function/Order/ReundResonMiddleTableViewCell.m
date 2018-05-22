//
//  ReundResonMiddleTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/8/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ReundResonMiddleTableViewCell.h"

@implementation ReundResonMiddleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.commitButton.layer.cornerRadius = 5;
    self.commitButton.layer.masksToBounds = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textView.placeholder = @"字数不超过50字!";
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.masksToBounds = YES;
    [self.textView setPlaceholderColor:_Colorhex(0xc8c8c8)];
    
    self.contentView.backgroundColor = _Colorhex(0xf1f1f1);
}



- (IBAction)commitAction:(id)sender {
    if (self.commitActionBlock) {
        self.commitActionBlock(self.textView.text);
    }
}
@end
