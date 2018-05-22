//
//  ReturnManTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/3.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailDTO.h"

@interface ReturnManTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *createdTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *rejectedTimeLabel;

@property (nonatomic,strong) OrderDetailDTO *dto;


@end
