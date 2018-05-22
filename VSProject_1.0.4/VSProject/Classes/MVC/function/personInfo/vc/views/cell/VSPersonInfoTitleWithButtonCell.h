//
//  VSPersonInfoTitleWithButton.h
//  VSProject
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSPersonInfoTitleCell.h"

@class VSPersonInfoTitleWithButtonCell;
@protocol VSPersonInfoTitleWithButtonCellDelegate <NSObject>

@optional
- (void)personInfoCellCheckClicked:(VSPersonInfoTitleWithButtonCell*)sender;

@end

@interface VSPersonInfoTitleWithButtonCell : VSPersonInfoTitleCell

_PROPERTY_NONATOMIC_WEAK(id<VSPersonInfoTitleWithButtonCellDelegate>, delegate);

@end
