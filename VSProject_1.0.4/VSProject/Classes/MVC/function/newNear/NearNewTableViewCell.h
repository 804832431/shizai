//
//  NearNewTableViewCell.h
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NearNewProduct;

@interface NearNewTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *adImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *companyLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *orderNumLabel;

@property (nonatomic, strong) UIView *lineView;

- (void)setData:(NearNewProduct *)dto;

@end
