//
//  PartnerCollectionViewCell.m
//  VSProject
//
//  Created by pangchao on 17/1/5.
//  Copyright © 2017年 user. All rights reserved.
//

#import "PartnerCollectionViewCell.h"

@implementation PartnerCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (MainWidth)/3.000000f, 30.0f)];
        contentV.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:contentV];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [_imageView  clipsToBounds];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [contentV addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentV.mas_centerX);
            make.width.equalTo(@(100.0f));
            make.centerY.equalTo(contentV.mas_centerY);
            make.height.equalTo(@(30.0f));
        }];
        
    }
    return self;
}

@end
