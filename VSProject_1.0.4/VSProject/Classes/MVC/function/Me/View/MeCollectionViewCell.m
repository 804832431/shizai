//
//  MeCollectionViewCell.m
//  VSProject
//
//  Created by pangchao on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MeCollectionViewCell.h"

@implementation MeCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (MainWidth - Get750Width(7.5f))/3.0000f, Get750Width(148.0f))];
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
        _nameLabel.alpha = 0.8f;
        _nameLabel.font = [UIFont systemFontOfSize:15.0f];
        _nameLabel.textColor = _COLOR_HEX(0x302f37);
        [contentV addSubview:_nameLabel];
        
        __weak typeof(self) weakSelf = self;
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentV.mas_centerX);
            make.width.equalTo(@(Get750Width(60.0f)));
            make.height.equalTo(@(Get750Width(60.0f)));
            make.top.equalTo(weakSelf.mas_top).offset(Get750Width(30.0f));
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentV.mas_centerX);
            make.top.equalTo(self.imageView.mas_bottom).offset(Get750Width(18.0f));
            make.height.equalTo(@(Get750Width(30.0f)));
        }];
        
    }
    return self;
}

@end
