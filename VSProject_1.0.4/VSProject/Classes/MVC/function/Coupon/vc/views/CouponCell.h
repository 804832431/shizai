//
//  CouponCell.h
//  VSProject
//
//  Created by certus on 16/4/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *couponImage;
@property (strong, nonatomic) IBOutlet UILabel *parValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *overTimeImage;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

- (void)vp_updateUIWithModel:(id)model;

@end
