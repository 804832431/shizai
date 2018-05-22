//
//  EditCollectionViewCell.h
//  VSProject
//
//  Created by certus on 15/11/24.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

#define margin_dailyCell          (MainWidth < 400 ? 20 : 76.0/2.6)

@interface EditCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *editBg;

@end
