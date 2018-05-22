//
//  SpacePurchaseTableViewCell.h
//  VSProject
//
//  Created by pangchao on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpaceListModel;

@interface SpacePurchaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *backgroupImageView;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UILabel *titleLabel;

+ (CGFloat)getHeight;

- (void)setModel:(SpaceListModel *)model;

@end
