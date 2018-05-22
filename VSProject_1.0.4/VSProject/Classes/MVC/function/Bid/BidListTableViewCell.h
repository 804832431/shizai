//
//  BidListTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BidProject.h"

@interface BidListTableViewCell : UITableViewCell

@property (weak, nonatomic) BidProject *dto;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameWidthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *bidTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *bidMoneyTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bidAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *bidMoneyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bidStatusBgImageView;
@property (weak, nonatomic) IBOutlet UILabel *bidStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *bidBeginTime;

@property (weak, nonatomic) IBOutlet UILabel *bidEndTime;
@property (weak, nonatomic) IBOutlet UILabel *ToLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *tenderWinnerLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tenderHigh;

@end
