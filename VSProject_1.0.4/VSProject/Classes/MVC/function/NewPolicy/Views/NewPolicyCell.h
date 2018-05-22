//
//  NewPolicyCell.h
//  VSProject
//
//  Created by apple on 11/4/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPolicyModel.h"

@interface NewPolicyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *whiteContentView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *gongshiLabel;
@property (weak, nonatomic) IBOutlet UILabel *butieLabel;
@property (weak, nonatomic) IBOutlet UILabel *butieTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfButie;

- (void)setDataSource:(NewPolicyModel *)policyModel;

@end
