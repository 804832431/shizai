//
//  PolicyCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/7/27.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PolicyModel.h"

@interface BPolicyCell : UITableViewCell

@property (nonatomic,strong) UIImageView *flagImageView;

@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong) PolicyModel *model;

@end
