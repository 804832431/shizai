//
//  NearCollectionViewCell.m
//  VSProject
//
//  Created by 张海东 on 2017/1/8.
//  Copyright © 2017年 user. All rights reserved.
//

#import "NearCollectionViewCell.h"

@implementation NearCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *contentV = [[UIView alloc]initWithFrame:self.bounds];
        contentV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentV];
        
        _c_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        //        _c_imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_c_imageView];
        
        _c_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _c_titleLabel.backgroundColor = [UIColor clearColor];
        _c_titleLabel.textAlignment = NSTextAlignmentCenter;
        _c_titleLabel.numberOfLines = 1;
        _c_titleLabel.adjustsFontSizeToFitWidth = YES;
        _c_titleLabel.textColor = _COLOR_BLACK;
        _c_titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_c_titleLabel];
        
        CGFloat height =  160/750.0 * [UIScreen mainScreen].bounds.size.width;
        
        [_c_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(self.mas_left).offset(13);
            make.width.equalTo(@(height - 30));
            make.height.equalTo(@((height - 30)));
            make.centerX.equalTo(self);
            
        }];
        
        [_c_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(_c_imageView.mas_bottom).offset(5);
            make.height.equalTo(@20);
            make.bottom.equalTo(self).offset(-2);
        }];
        
    }
    
    return self;
}

@end
