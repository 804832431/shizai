//
//  PersonalHomeView.h
//  VSProject
//
//  Created by 姚君 on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSView.h"
#import "NavigationBar.h"
#import "HomeViewController.h"

#define PageTop         110/3

#define PointGap        26

#define FirstLeft       0
/*-----圆点------*/
#define CirclePadLeft   84/3
#define CircleRadius    4
#define CircleBgColor   _COLOR_HEX(0x72eaaf)
/*-----时间------*/
#define TimePadLeft    57
#define TimeBgColor     _COLOR_HEX(0x8dcfb8)
#define TimeBgHeight    20
#define TimeBgFont      [UIFont systemFontOfSize:18.f]
/*-----上方方块------*/
#define GirdItemWidth   43
#define GirdItemRadius  10
#define GirdItemPadLeft1    200
#define GirdItemPadLeft2    280
/*-----供选择方块------*/
#define BottomGirdItemWidth   50
#define BottomGirdItemGap   10
#define ScrollPadLeft   50
#define ScrollPadTop   MainHeight-100
/*-----回收站------*/
#define RecycleBinPadLeft   MainWidth/2-27
#define RecycleBinPadTop    84

@interface PersonalHomeView : VSView

_PROPERTY_NONATOMIC_STRONG(NavigationBar, navigation);
_PROPERTY_NONATOMIC_STRONG(HomeViewController, selfController);
_PROPERTY_NONATOMIC_STRONG(UIImageView, backgroundView);
_PROPERTY_NONATOMIC_STRONG(UIScrollView, scrollView);
_PROPERTY_NONATOMIC_STRONG(UIScrollView, bottomScrollView);
_PROPERTY_NONATOMIC_STRONG(NSArray, timeStamp);
_PROPERTY_NONATOMIC_ASSIGN(BOOL, isEditting);

- (void)requestLayout;

@end
