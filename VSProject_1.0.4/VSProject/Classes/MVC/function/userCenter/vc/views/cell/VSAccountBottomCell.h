//
//  VSAccountBottomCell.h
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class VSAccountBottomCell;
@protocol VSAccountBottomCellDelegate <NSObject>

@optional
- (void)vp_registerClicked:(VSAccountBottomCell*)sender;

- (void)vp_forgotClicked:(VSAccountBottomCell*)sender;

@end

@interface VSAccountBottomCell : VSBaseTableViewCell

_PROPERTY_NONATOMIC_WEAK(id<VSAccountBottomCellDelegate>, delegate);

@end
