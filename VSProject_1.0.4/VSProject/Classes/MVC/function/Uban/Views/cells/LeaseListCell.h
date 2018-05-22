//
//  LeaseListCell.h
//  VSProject
//
//  Created by certus on 16/4/14.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RentalModel.h"

@interface LeaseListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *areaLabel;

- (void)vp_updateUIWithModel:(RentalModel *)model;

@end
