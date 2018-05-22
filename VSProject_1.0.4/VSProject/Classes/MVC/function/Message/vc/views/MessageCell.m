//
//  MessageCell.m
//  VSProject
//
//  Created by certus on 16/1/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
    _m_imageView.layer.cornerRadius = _m_imageView.frame.size.width/2;
    _m_imageView.backgroundColor = [UIColor greenColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)vp_updateUIWithModel:(id)model
{
    if ([model isKindOfClass:[MessageModel class]]) {
        MessageModel *m_model = (MessageModel *)model;
        self.m_timeLabel.text = [NSDate timeSeconds:m_model.createTime.longLongValue];
        self.m_titleLabel.text = m_model.message;
        if (m_model.isRead && [m_model.isRead isEqual:@"Y"]) {
            self.m_titleLabel.textColor = _COLOR_HEX(0x999999);
        }else {
            self.m_titleLabel.textColor = _COLOR_HEX(0x333333);
        }
    }
    
}


@end
