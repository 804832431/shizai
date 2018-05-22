//
//  EditCollectionViewCell.m
//  VSProject
//
//  Created by certus on 15/11/24.
//  Copyright © 2015年 user. All rights reserved.
//

#import "EditCollectionViewCell.h"

@implementation EditCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        CGFloat width_dailyCell = MainWidth/8;
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, width_dailyCell, width_dailyCell, width_dailyCell/2)];
        _nameLabel.numberOfLines = 2;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
        if (width_dailyCell > 65) {
            _nameLabel.font = [UIFont systemFontOfSize:13.0f];
        }else {
            _nameLabel.font = [UIFont systemFontOfSize:10.0f];
        }
        [self.contentView addSubview:_nameLabel];
        
        _editBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width_dailyCell, width_dailyCell)];
        _editBg.image = [UIImage imageNamed:@"edit_bg"];
        [_editBg  clipsToBounds];
        _editBg.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_editBg];

        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width_dailyCell, width_dailyCell)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageView];

    }
    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    float itemW = self.frame.size.width;
    float itemH = self.frame.size.height;
    _imageView.frame = CGRectMake(15, 15, MIN(itemW, itemH-10)-30, MIN(itemW, itemH-10)-30);
    _nameLabel.frame = CGRectMake(0, itemH-15, itemW, 10);
    _editBg.frame = CGRectMake(0, 0, MIN(itemW, itemH-10), MIN(itemW, itemH-10));

}

@end
