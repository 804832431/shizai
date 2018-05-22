//
//  BidDepositTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/10/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BidProject.h"

@interface BidDepositTableViewCell : UITableViewCell

@property (nonatomic,strong) BidProject *bidPro;


@property (weak, nonatomic) IBOutlet UILabel *projectName;

@property (weak, nonatomic) IBOutlet UILabel *needDeposit;
@property (weak, nonatomic) IBOutlet UILabel *payDeposit;

@property (weak, nonatomic) IBOutlet UILabel *callbackDescription;

@end
