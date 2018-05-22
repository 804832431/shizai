//
//  VSUserListView.m
//  VSProject
//
//  Created by user on 15/1/30.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUserListView.h"
#import "VSTestCell1.h"
#import "VSTestCell2.h"

@implementation VSUserListView

- (NSArray*)vp_mutCellClasses
{
    return self.cellNameClasses;
}


_GETTER_BEGIN(NSArray, cellNameClasses)
{
    _cellNameClasses = @[ [VSTestCell1 class], [VSTestCell2 class] ];
}
_GETTER_END(cellNameClasses)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
