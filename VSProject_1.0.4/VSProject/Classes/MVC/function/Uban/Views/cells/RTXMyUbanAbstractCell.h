//
//  RTXMyUbanAbstractCell.h
//  VSProject
//
//  Created by XuLiang on 16/1/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class RTXMyUbanAbstractCell;

@protocol RTXMyUbanAbstractCellDelegate <NSObject>

- (void)ToOrderDetail:(id)model;

@end
@interface RTXMyUbanAbstractCell : VSBaseTableViewCell

@property(nonatomic,assign)id<RTXMyUbanAbstractCellDelegate> delegate;

@end
