//
//  HomeCCollectionViewCell.m
//  VSProject
//
//  Created by certus on 16/3/24.
//  Copyright © 2016年 user. All rights reserved.
//

#import "HomeCCollectionViewCell.h"

@implementation HomeCCollectionViewCell



- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *contentV = [[UIView alloc]initWithFrame:self.bounds];
        //        contentV.layer.cornerRadius = 10.f;
        //        contentV.layer.borderWidth = 1.f;
        //        contentV.layer.borderColor = _COLOR_HEX(0xdedede).CGColor;
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
        
        //        _c_subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        //        _c_subLabel.backgroundColor = [UIColor clearColor];
        //        _c_subLabel.textAlignment = NSTextAlignmentLeft;
        //        _c_subLabel.numberOfLines = 2;
        //        _c_subLabel.textColor = _COLOR_HEX(0x696969);
        //        _c_subLabel.font = [UIFont systemFontOfSize:10];
        //        [self.contentView addSubview:_c_subLabel];
        //
        //        _c_red = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        //        _c_red.backgroundColor = [UIColor redColor];
        //        _c_red.layer.cornerRadius = 2.5f;
        //        _c_red.clipsToBounds = YES;
        //        [_c_red setHidden:YES];
        //        [self.contentView addSubview:_c_red];
        
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
        
        //        [_c_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.c_imageView.mas_right).offset(11);
        //            make.right.equalTo(self.mas_right).offset(-13);
        //            make.top.equalTo(self.c_titleLabel.mas_bottom);
        //            make.height.equalTo(@30);
        //        }];
        //        [_c_red mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.mas_right).offset(-15);
        //            make.top.equalTo(self.mas_top).offset(10);
        //            make.width.equalTo(@5);
        //            make.height.equalTo(@5);
        //        }];
        
    }
    
    return self;
}

@end
