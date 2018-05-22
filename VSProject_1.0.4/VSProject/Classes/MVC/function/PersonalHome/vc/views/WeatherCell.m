//
//  WeatherCell.m
//  VSProject
//
//  Created by certus on 16/1/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "WeatherCell.h"

@implementation WeatherCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    self.bgView.layer.cornerRadius = 7.f;
    self.difLabel.layer.cornerRadius = 7.5f;
    self.difLabel.clipsToBounds = YES;
    self.tempLabel.adjustsFontSizeToFitWidth = YES;
    self.difLabel.adjustsFontSizeToFitWidth = YES;
    self.cityLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
