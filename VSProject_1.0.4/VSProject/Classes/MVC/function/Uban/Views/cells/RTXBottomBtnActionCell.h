//
//  RTXBottomBtnActionCell.h
//  VSProject
//
//  Created by XuLiang on 15/11/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class RTXBottomBtnActionCell;
@protocol RTXBottomBtnActionCellDelegate <NSObject>

@optional
- (void)vp_btnActionClicked:(RTXBottomBtnActionCell*)sender;

@end

@interface RTXBottomBtnActionCell : VSBaseTableViewCell

_PROPERTY_NONATOMIC_WEAK(id<RTXBottomBtnActionCellDelegate>, delegate);

@end
