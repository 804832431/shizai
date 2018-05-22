//
//  ServerCollectionCell.h
//  VSProject
//
//  Created by pch_tiger on 16/12/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

#define server_cellheight      Get750Width(185.0f)
#define cellHeight             Get750Width(160.0f)

@interface ServerCollectionCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *nameLabel;

@end
