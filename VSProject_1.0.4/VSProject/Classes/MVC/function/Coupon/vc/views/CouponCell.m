//
//  CouponCell.m
//  VSProject
//
//  Created by certus on 16/4/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import "CouponCell.h"
#import "CouponModel.h"

@implementation CouponCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)vp_updateUIWithModel:(id)model {
    if ([model isKindOfClass:[CouponModel class]]) {
        CouponModel *c_model = model;
        if (c_model.status.intValue == 0) {
            [self.overTimeImage setHidden:YES];
            self.couponImage.image = [UIImage imageNamed:@"Coupon"];
        }else if (c_model.status.intValue == 1) {
            [self.overTimeImage setHidden:NO];
            self.overTimeImage.image = [UIImage imageNamed:@"used"];
            self.couponImage.image = [UIImage imageNamed:@"overTimeCoupon"];
        }else if (c_model.status.intValue == 2) {
            [self.overTimeImage setHidden:NO];
            self.overTimeImage.image = [UIImage imageNamed:@"overTime"];
            self.couponImage.image = [UIImage imageNamed:@"overTimeCoupon"];
        }
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",c_model.value];
        self.parValueLabel.text = c_model.couponName;//[NSString stringWithFormat:@"%@元优惠券",c_model.value];
        self.amountLabel.text = c_model.couponDesc;
        self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate timeMinutes:c_model.startTime.longLongValue],[NSDate timeMinutes:c_model.endTime.longLongValue]];

    }

}
@end
