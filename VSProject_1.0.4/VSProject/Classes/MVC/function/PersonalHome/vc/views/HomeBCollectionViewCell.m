//
//  HomeBCollectionViewCell.m
//  VSProject
//
//  Created by certus on 16/3/24.
//  Copyright © 2016年 user. All rights reserved.
//

#import "HomeBCollectionViewCell.h"

#define cellHeight  (homeb_cellheight * 71/124.0)

@implementation HomeBCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, homeb_cellheight, cellHeight)];
        //        contentV.layer.borderWidth = 0.5f;
        //        contentV.layer.borderColor = _COLOR_HEX(0xd3d3d3).CGColor;
        contentV.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:contentV];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [_imageView  clipsToBounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [contentV addSubview:_imageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.numberOfLines = 2;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:13.f];
        _nameLabel.textColor = _COLOR_HEX(0x333333);
        [contentV addSubview:_nameLabel];
        
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = _COLOR_HEX(0xcdcdcd);
        [contentV addSubview:_bottomLineView];
        
        _rightLineView = [UIView new];
        _rightLineView.backgroundColor = _COLOR_HEX(0xcdcdcd);
        [contentV addSubview:_rightLineView];
        
        __weak typeof(self) weakSelf = self;
        
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.leading.trailing.equalTo(weakSelf);
            make.height.mas_equalTo(0.5);
        }];
        
        [_rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.trailing.equalTo(weakSelf);
            make.width.mas_equalTo(0.5);
        }];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentV.mas_centerX);
            make.width.equalTo(@(homeb_cellheight/3));
            make.height.equalTo(@(homeb_cellheight/4));
            make.centerY.equalTo(weakSelf).offset(-10);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentV.mas_centerX);
            //            make.width.equalTo(@(homeb_cellheight/2));
            make.top.equalTo(self.imageView.mas_bottom).offset(-5);
            make.height.equalTo(@(homeb_cellheight/3));
        }];
        
    }
    return self;
}

@end
