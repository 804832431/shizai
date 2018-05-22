//
//  SpaceLeaseListCell.h
//  VSProject
//
//  Created by pangchao on 2017/10/23.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpaceProjectModel;

@interface SpaceLeaseListCell : UITableViewCell

@property (nonatomic, strong)SpaceProjectModel *spaceProjectModel;

- (void)setDataSource:(SpaceProjectModel *)spaceProjectModel;

+ (CGFloat)getHeight;

@end
