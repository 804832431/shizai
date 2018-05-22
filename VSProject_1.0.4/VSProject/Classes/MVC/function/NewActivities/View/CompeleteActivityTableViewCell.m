//
//  CompeleteActivityTableViewCell.m
//  VSProject
//
//  Created by apple on 1/5/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "CompeleteActivityTableViewCell.h"

@implementation CompeleteActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSource:(NewActivityModel *)activityModel {
    [self.activityTitle setText:activityModel.title];
    [self.activityImageView sd_setImageWithString:activityModel.smallImage placeholderImage:[UIImage imageNamed:@"activity_list_default"]];
}

@end
