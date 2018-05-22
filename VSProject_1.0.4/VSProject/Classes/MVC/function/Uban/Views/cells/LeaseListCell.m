//
//  LeaseListCell.m
//  VSProject
//
//  Created by certus on 16/4/14.
//  Copyright © 2016年 user. All rights reserved.
//

#import "LeaseListCell.h"

@implementation LeaseListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)vp_updateUIWithModel:(RentalModel *)model{
    
    if ([model isKindOfClass:[RentalModel class]]) {
        self.nameLabel.text = model.buildingName;
        self.priceLabel.text = [NSString stringWithFormat:@"%@元/平/天",model.price];
        self.areaLabel.text = [NSString stringWithFormat:@"%@平方米",model.roomArea];
    }
}
@end
