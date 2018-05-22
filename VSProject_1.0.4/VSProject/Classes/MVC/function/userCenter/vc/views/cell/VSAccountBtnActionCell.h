//
//  VSAccountBtnActionCell.h
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class VSAccountBtnActionCell;
@protocol VSAccountBtnActionCellDelegate <NSObject>

@optional
- (void)vp_btnActionClicked:(VSAccountBtnActionCell*)sender;

@end

@interface VSAccountBtnActionCell : VSBaseTableViewCell

_PROPERTY_NONATOMIC_WEAK(id<VSAccountBtnActionCellDelegate>, delegate);
- (void)btnEnabled:(BOOL)m_bool;
@end
