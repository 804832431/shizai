//
//  UIView+InitUI.h
//  QianbaoIM
//
//  Created by tiezhang on 14-9-22.
//  Copyright (c) 2014年 liu nian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (InitUI)

//+ (UITableViewCell*)wm_loadCellXib:(Class)xibCellClass;

+ (UIView*)wm_loadViewXib:(Class)xibClass;

@end
