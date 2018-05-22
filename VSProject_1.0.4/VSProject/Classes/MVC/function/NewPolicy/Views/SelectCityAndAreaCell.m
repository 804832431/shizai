//
//  SelectCityAndAreaCell.m
//  VSProject
//
//  Created by apple on 11/8/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "SelectCityAndAreaCell.h"

@implementation SelectCityAndAreaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.separatorLine setBackgroundColor:_Colorhex(0xefefef)];
    [self.nameLabel setTextColor:_Colorhex(0xcc302f35)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
