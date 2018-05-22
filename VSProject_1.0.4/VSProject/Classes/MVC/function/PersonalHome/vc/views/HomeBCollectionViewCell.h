//
//  HomeBCollectionViewCell.h
//  VSProject
//
//  Created by certus on 16/3/24.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

#define homeb_cellheight          (MainWidth/3.000000)

@interface HomeBCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *nameLabel;

@property (nonatomic,strong) UIView *bottomLineView;
@property (nonatomic,strong) UIView *rightLineView;


@end
