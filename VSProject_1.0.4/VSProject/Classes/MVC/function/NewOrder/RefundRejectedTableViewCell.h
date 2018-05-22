//
//  RefundRejectedTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/2.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailDTO.h"

@interface RefundRejectedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *rejectResonLabel;

- (IBAction)playCall:(id)sender;

@property (nonatomic,strong) OrderDetailDTO *dto;

@end
