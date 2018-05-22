//
//  ReturnTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/2.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailDTO.h"

@interface ReturnTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *createdTimeLabel;

@property (nonatomic,strong) OrderDetailDTO *dto;

@property (nonatomic,strong) NSArray *returnStatusList;

@end
