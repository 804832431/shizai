//
//  CaseTableViewCell.h
//  VSProject
//
//  Created by pangchao on 17/1/5.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

@interface CaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *introductionLabel;

- (void)setModel:(NewsModel *)model;

@end
