//
//  SZShareTableViewCell.h
//  VSProject
//
//  Created by pangchao on 16/12/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PolicyModel;

@interface SZShareTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView; // 宣传图片

@property (nonatomic, strong) UILabel *titleLabel; // 分享标题

@property (nonatomic, strong) UILabel *timelabel; // 时间

@property (nonatomic, strong) UIView *bottomView;

- (void)setModel:(PolicyModel *)model;

@end
