//
//  GreatActivityCell.m
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "GreatActivityCell.h"

@implementation GreatActivityCell

- (void)awakeFromNib {
    // Initialization code
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)vp_updateUIWithModel:(id)model
{
    if ([model isKindOfClass:[ActivityModel class]]) {
        ActivityModel *a_model = (ActivityModel *)model;
        self.titleLabel.text = a_model.title;
        self.timeLabel.text = [NSString stringWithFormat:@"活动时间：%@",[NSDate timeMinutes:a_model.eventTime.longLongValue]];
        self.adressLabel.text = [NSString stringWithFormat:@"活动地点：%@",a_model.eventLocation];
        if (a_model.personMax.intValue == 0) {
            self.limitCountLabel.text = [NSString stringWithFormat:@"限制人数：不限"];
        }else {
            self.limitCountLabel.text = [NSString stringWithFormat:@"限制人数：%@人",a_model.personMax];
        }

        self.feeLabel.text = [NSString stringWithFormat:@"活动费用：￥%@元/人",a_model.charge];
        
        NSString *status = a_model.status;
        switch (status.intValue) {
            case PRE_PUBLISH:
                _angleImageView.image = [UIImage imageNamed:@"signup"];
                self.titleLabel.textColor = _COLOR_HEX(0xf8b6b6);
                break;
                
            case PRE_START:
                _angleImageView.image = [UIImage imageNamed:@"signup"];
                self.titleLabel.textColor = _COLOR_HEX(0xf8b6b6);
                break;

            case START:
                _angleImageView.image = [UIImage imageNamed:@"carriedout"];
                self.titleLabel.textColor = _COLOR_HEX(0x35b38d);
                break;

            case END:
                _angleImageView.image = [UIImage imageNamed:@"ended"];
                self.titleLabel.textColor = _COLOR_HEX(0x000000);
                break;

            default:
                _angleImageView.image = [UIImage imageNamed:@"ended"];
                self.titleLabel.textColor = _COLOR_HEX(0x000000);
                break;
        }
    }
    
}

@end
