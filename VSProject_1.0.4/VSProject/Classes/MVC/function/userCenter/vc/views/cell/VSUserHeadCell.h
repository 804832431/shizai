//
//  VSUserHeadCell.h
//  VSProject
//
//  Created by user on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class VSUserHeadCell;
@protocol VSUserHeadCellDelegate <NSObject>

@optional
- (void)vp_userHeadCellLoginClicked:(VSUserHeadCell*)sender;

- (void)vp_userHeadCellRegisterClicked:(VSUserHeadCell*)sender;

@end

@interface VSUserHeadCell : VSBaseTableViewCell

_PROPERTY_NONATOMIC_WEAK(id<VSUserHeadCellDelegate>, delegate);

@end
