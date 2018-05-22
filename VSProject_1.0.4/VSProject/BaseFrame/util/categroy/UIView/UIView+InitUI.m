//
//  UIView+InitUI.m
//  QianbaoIM
//
//  Created by tiezhang on 14-9-22.
//  Copyright (c) 2014年 liu nian. All rights reserved.
//

#import "UIView+InitUI.h"

@implementation UIView (InitUI)

+ (UIView*)wm_loadViewXib:(Class)xibClass
{
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(xibClass) owner:nil options:nil];
    
    if([cells count] > 0)
    {
        return cells[0];  
    }
    else
    {
        return nil;
    }
}

@end
