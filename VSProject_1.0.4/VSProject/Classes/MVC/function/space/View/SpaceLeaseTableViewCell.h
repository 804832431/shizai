//
//  SpaceLeaseTableViewCell.h
//  VSProject
//
//  Created by pangchao on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpaceListModel;

@interface SpaceLeaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView; // 图标

@property (nonatomic, strong) UILabel *titleLabel; // 标题

@property (nonatomic, strong) UILabel *roomInfoLabel; // 面积，工位数量

@property (nonatomic, strong) UILabel *singlePriceLabel; // 价格

@property (nonatomic, strong) UIView *bottomLine;

+ (CGFloat)getHeight;

- (void)setModel:(SpaceListModel *)model;

@end
