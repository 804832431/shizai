//
//  BusinessCollectionViewCell.m
//  VSProject
//
//  Created by pangchao on 17/1/5.
//  Copyright © 2017年 user. All rights reserved.
//

#import "BusinessCollectionViewCell.h"

@implementation BusinessCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (MainWidth)/2.000000f, 175.0f/2)];
        contentV.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:contentV];
        
        __weak typeof(self)weakself = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakself.contentView);
            make.width.equalTo(@((MainWidth - 24.0f)/2.000000f));
        }];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [_imageView  clipsToBounds];
        _imageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [contentV addSubview:_imageView];
        
        UIView *blackClearView = [[UIView alloc] init];
        [blackClearView setBackgroundColor:ColorWithHex(0x000000, 0.4)];
        [contentV addSubview:blackClearView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:18.0f];
        _nameLabel.textColor = _COLOR_HEX(0xffffff);
        [contentV addSubview:_nameLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.layer.masksToBounds = YES;
        _detailLabel.layer.borderColor = _COLOR_HEX(0xffffff).CGColor;
        _detailLabel.layer.cornerRadius = 4.0f;
        _detailLabel.layer.borderWidth = 0.5f;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = _COLOR_HEX(0xffffff);
        _detailLabel.font = [UIFont systemFontOfSize:11.0f];
        _detailLabel.text = @"查看详情";
        [contentV addSubview:_detailLabel];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentV.mas_centerX);
            make.width.equalTo(@((MainWidth - 24.0f)/2));
            make.height.equalTo(@(175.0f/2));
        }];
        
        [blackClearView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentV.mas_centerX);
            make.width.equalTo(@((MainWidth - 24.0f)/2));
            make.height.equalTo(@(175.0f/2));
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentV.mas_centerX);
            make.top.equalTo(contentV.mas_top).offset(55.0f/2);
            make.height.equalTo(@(18.0f));
        }];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentV.mas_centerX);
            make.top.equalTo(_nameLabel.mas_bottom).offset(14.0f);
            make.height.equalTo(@(20.0f));
            make.width.equalTo(@(64.0f));
        }];
        
    }
    return self;
}

@end
