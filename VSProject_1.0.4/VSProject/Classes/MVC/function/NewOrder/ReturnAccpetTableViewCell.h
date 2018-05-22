//
//  ReturnAccpetTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/3.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailDTO.h"

@interface ReturnAccpetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *createdTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *acceptTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *compLabel;


@property (nonatomic,strong) OrderDetailDTO *dto;

@property (nonatomic,strong) NSArray *returnStatusList;

@end
