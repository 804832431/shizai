//
//  EnterpriseTableViewCell.h
//  VSProject
//
//  Created by pangchao on 16/12/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EnterpriseModel;

@interface EnterpriseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *backgroundImageVIew;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *enterpriseNameLabel;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIView *blackClearView;

- (void)setModel:(EnterpriseModel *)model;

@end
