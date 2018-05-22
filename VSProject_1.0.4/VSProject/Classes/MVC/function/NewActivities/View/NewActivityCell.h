//
//  NewActivityCell.h
//  VSProject
//
//  Created by apple on 10/16/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewActivityModel.h"

@interface NewActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *enrollLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfEnrollLabel;
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *chargeLabel;


- (void)setDataSource:(NewActivityModel *)activityModel;

@end
