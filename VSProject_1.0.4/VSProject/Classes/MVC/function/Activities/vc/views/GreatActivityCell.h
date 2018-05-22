//
//  GreatActivityCell.h
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

typedef enum : NSUInteger {
    PRE_PUBLISH,
    PRE_START,
    START,
    END,
} ACT_STATUS;


@interface GreatActivityCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *topLineLabel;

@property (strong, nonatomic) IBOutlet UILabel *bottomLineLabel;

@property (strong, nonatomic) IBOutlet UIImageView *actImageView;

@property (strong, nonatomic) IBOutlet UIImageView *angleImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *adressLabel;

@property (strong, nonatomic) IBOutlet UILabel *limitCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *feeLabel;

- (void)vp_updateUIWithModel:(id)model;

@end
