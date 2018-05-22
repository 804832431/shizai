//
//  WMBaseTableViewCell.h
//  beautify
//
//  Created by user on 14/11/20.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VSBaseTableViewCellProtocol <UIInitProtocol>

@optional

- (void)vp_updateCellInfoWithModel:(id)model withSuperWidth:(CGFloat)t_superWidth;

- (void)vp_updateCellInfoWithModel:(id)model indexPath:(NSIndexPath*)indexPath;

+ (CGFloat)vp_cellHeightWithModel:(id)model __deprecated_msg("Block type deprecated. Use `vp_cellHeightWithModel:withSuperWidth:");

+ (CGFloat)vp_cellHeightWithModel:(id)model withSuperWidth:(CGFloat)t_superWidth;

@end


@interface VSBaseTableViewCell : UITableViewCell<VSBaseTableViewCellProtocol>

- (void)vm_showBottonLine:(BOOL)show;

- (void)vm_showBottonLine:(BOOL)show lineColor:(UIColor *)lineColor;

@end
