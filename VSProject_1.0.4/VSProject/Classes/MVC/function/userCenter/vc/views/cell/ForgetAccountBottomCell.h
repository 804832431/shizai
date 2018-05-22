//
//  ForgetAccountBottomCell.h
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class ForgetAccountBottomCell;
@protocol ForgetAccountBottomCellDelegate <NSObject>

@optional
- (void)vp_loginClicked:(ForgetAccountBottomCell*)sender;

@end

@interface ForgetAccountBottomCell : VSBaseTableViewCell

_PROPERTY_NONATOMIC_WEAK(id<ForgetAccountBottomCellDelegate>, delegate);

@end
