//
//  MeSettingTableViewCell.h
//  VSProject
//
//  Created by pangchao on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_HEIGHT 50.0f

@interface MeSettingTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

+ (CGFloat)getHeight;

@end
